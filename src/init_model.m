% Script to initialize simple chemostat model

% -------------------------- %
%       Set tracers          %
% -------------------------- %
config.tracers = {'om','o2','no3','no2','nh4','n2o','n2',... % chemistry
                  'aer','nar','nai','nao',...                % aerobic and NO3-reducing heterotrophs
				  'nir','nio','nos',...                      % NO2 and N2O reducing heterotrophs
				  'aoa','nob','aox'};                        % chemoautotrophs
config.units   = {'mmol C m$^{-3}$','mmol O$_2$ m$^{-3}$','mmol N m$^{-3}$','mmol N m$^{-3}$','mmol N m$^{-3}$','mmol N$_2$ m$^{-3}$','mmol N$_2$ m$^{-3}$',...
                  'mmol C m$^{-3}$','mmol C m$^{-3}$','mmol C m$^{-3}$','mmol C m$^{-3}$',...
				  'mmol C m$^{-3}$','mmol C m$^{-3}$','mmol C m$^{-3}$',...
				  'mmol C m$^{-3}$','mmol C m$^{-3}$','mmol C m$^{-3}$'};
config.titles  = {'OM','O$_2$','NO$^{-}_3$','NO$^{-}_2$','NH$^{+}_4$','N$_2$O','N$_2$'...
				  '$B^{het}_{o2}$','$B^{het}_{no3 \rightarrow no2}$','$B^{het}_{no3 \rightarrow n2o}$','$B^{het}_{no3 \rightarrow n2}$',... 
				  '$B^{het}_{no2 \rightarrow n2o}$','$B^{het}_{no2 \rightarrow n2}$','$B^{het}_{n2o \rightarrow n2}$',... 
				  '$B^{che}_{ao}$','$B^{che}_{no}$','$B^{che}_{amx}$'};
config.ftypes  = {'aer','nar','nai','nao','nir','nio','nos','aoa','nob','aox'};

% -------------------------- %
%     Get ftype params       %
% -------------------------- %
ftype_params

% -------------------------- %
%     Set timestepping       %
% -------------------------- %
config.dt         = 7200;                            % in seconds (hourly)
config.runTime    = 3;                               % in years
config.runTime    = config.runTime.*365.*86400;      % convert years to seconds
config.nt         = config.runTime./config.dt;       % number of timesteps
config.his_stride = 1;                               % write every 'x' steps
config.his_dt     = [1:config.his_stride:config.nt]; % save all timesteps
config.years2plot = 1;                               % number of years to show in time-series 

% Set timesteps to report
config.disp_dt      = floor(max(config.his_dt)/10):floor(max(config.his_dt)/10):max(config.his_dt);
config.disp_dt(end) = max(config.his_dt);

% -------------------------- %
%   Set initial conditions   %
% -------------------------- %
for i = 1:length(config.tracers)
	ic.(config.tracers{i}) = 0; % mmol m^-3
end
% Give biology an initial concentration
ic.aer = 0.001; ic.nar = 0.001; ic.nai = 0.001;
ic.nao = 0.001; ic.nir = 0.001; ic.nio = 0.001;
ic.nos = 0.001; ic.aoa = 0.001; ic.nob = 0.001; ic.aox = 0.001;

% -------------------------- %
%    Set upwelling supply    %
% -------------------------- %
for i = 1:length(config.tracers)
	inputs.(config.tracers{i}) = opt.inputs.(config.tracers{i}); % mmol m^-3
end

% -------------------------- %
%     Set variable inputs    %
% -------------------------- %
pulse.t   = [1:config.dt:config.runTime]./(86400); % time in days
omega     = (2*pi/opt.period);
high_freq = opt.amplitude .* sin(omega.*pulse.t); 
for i = 1:length(config.tracers)
	pulse.(config.tracers{i}) = inputs.(config.tracers{i}).*ones(1,length(high_freq));
end
pulse.om  = inputs.om + high_freq;

