function [sms,diag,tr] = sources_sinks(tr,params,opt)
% Sources and sinks function

% Get list of ftypes
ftypes = {'aer','nar','nai','nao','nir','nio','nos','aoa','nob','aox'};

% Cycle through functional types and calculate growth
for i = 1:length(ftypes)
	% Get oxidant and reductant concentration
	this_oxy = tr.(params.(ftypes{i}).oxy);
	this_red = tr.(params.(ftypes{i}).red);
	% Initialize uptake
	red_up = 0; % uM red / B s
	oxy_up = 0; % uM oxy / B s
	% Calculate uptake if tracers > 0
	if this_oxy > 0 & this_red > 0
		% Get limitation terms
		red_lim = this_red ./ (this_red + params.(ftypes{i}).K_red);
		oxy_lim = this_oxy ./ (this_oxy + params.(ftypes{i}).K_oxy);
		% Get uptake
		red_up = (params.(ftypes{i}).Vmax_red .* red_lim)./params.(ftypes{i}).y_red;
		oxy_up = (params.(ftypes{i}).Vmax_oxy .* oxy_lim)./params.(ftypes{i}).y_oxy;
	end
	% Growth via Liebig's law of the minimum
	if red_up > 0 & oxy_up > 0
		mu = min(red_up,oxy_up);
		limit = 0;
		if red_up>oxy_up
			limit = 1;
		end
	else
		mu = 0;
		limit = 0;
	end
	% Calculate biomass accumulation and loss rate
	out.(ftypes{i}).growth = mu;                 % 1/s
	out.(ftypes{i}).bio    = mu.*tr.(ftypes{i}); % uM/s
	out.(ftypes{i}).limit  = limit;              % 1 = oxi, 0 = red
	% Turn off functional type?
	if ~opt.(ftypes{i})
		out.(ftypes{i}).growth = 0;
		out.(ftypes{i}).bio    = 0;
		opt.(ftypeS{i}).limit  = 0;
	end
end

% Collect sources-minus-sinks
% ---- OM ---- %
sms.om = 0 ...
	 - out.aer.bio.*params.aer.y_red ... % aer consumption (reductant)
	 - out.nar.bio.*params.nar.y_red ... % nar consumption (reductant)
	 - out.nai.bio.*params.nai.y_red ... % nai consumption (reductant)
	 - out.nao.bio.*params.nao.y_red ... % nao consumption (reductant)
	 - out.nir.bio.*params.nir.y_red ... % nir consumption (reductant)
	 - out.nio.bio.*params.nio.y_red ... % nio consumption (reductant)
	 - out.nos.bio.*params.nos.y_red;    % nos consumption (reductant)

% ---- O2 ---- %
sms.o2 = 0 ...
	 - out.aer.bio.*params.aer.y_oxy ... % aer consumption (oxidant)
	 - out.aoa.bio.*params.aoa.y_oxy ... % aoa consumption (oxidant)
	 - out.nob.bio.*params.nob.y_oxy;    % nob consumption (oxidant)

% ---- NO3 ---- %
sms.no3 = 0 ...
	 + out.nob.bio.*params.nob.e_no3 ... % nob production (excretion)
     + out.aox.bio.*params.aox.e_no3 ... % aox production (excretion)
	 - out.nar.bio.*params.nar.y_oxy ... % nar consumption (oxidant)
	 - out.nai.bio.*params.nai.y_oxy ... % nai consumption (oxidant)
	 - out.nao.bio.*params.nao.y_oxy;    % nao consumption (oxidant)

% ---- NO2 ---- %
sms.no2 = 0 ...
	 + out.nar.bio.*params.nar.e_no2 ... % nar production (excretion)
	 - out.nir.bio.*params.nir.y_oxy ... % nir consumption (oxidant)
	 - out.nio.bio.*params.nio.y_oxy ... % nir consumption (oxidant)
	 - out.nob.bio.*params.nob.y_red ... % nob consumption (reductant)
	 - out.aox.bio.*params.aox.y_oxy;    % aox consumption (oxidant)

% ---- NH4 ---- %
sms.nh4 = 0 ...
	 + out.aer.bio.*params.aer.e_nh4 ... % aer production (excretion)
	 + out.nar.bio.*params.nar.e_nh4 ... % nar production (excretion)
	 + out.nai.bio.*params.nai.e_nh4 ... % nai production (excretion)
	 + out.nao.bio.*params.nao.e_nh4 ... % nao production (excretion)
	 + out.nir.bio.*params.nir.e_nh4 ... % nir production (excretion)
	 + out.nio.bio.*params.nio.e_nh4 ... % nio production (excretion)
	 + out.nos.bio.*params.nos.e_nh4 ... % nos production (excretion)
     - out.aoa.bio.*params.aoa.y_red ... % aoa consumption (reductant)
     - out.aox.bio.*params.aox.y_red;    % aox consumption (reductant)

% ---- N2 ---- %
sms.n2o = 0 ...
	 + out.nir.bio.*params.nir.e_n2o ... % nir production (excretion)
	 + out.nai.bio.*params.nai.e_n2o ... % nai production (excretion)
	 - out.nos.bio.*params.nos.y_oxy;    % nos consumption (oxidant)

% ---- N2 ---- %
sms.n2  = 0 ...
	 + out.nao.bio.*params.nao.e_n2 ... % nao production (excretion)
     + out.nio.bio.*params.nio.e_n2 ... % nio production (excretion)
     + out.aox.bio.*params.aox.e_n2;    % aox production (excretion)

% Collect ftype diagnostics 
ftype_diags = {'growth','bio','limit'};
for i = 1:length(ftypes)
	% Biomass accumulation
	sms.(ftypes{i}) = out.(ftypes{i}).bio;
	% Biomass dilution
	diag.([ftypes{i},'_loss']) = tr.(ftypes{i}) * opt.dilution; 
	% Diagnostics	
	for j = 1:length(ftype_diags)
		diag.([ftypes{i},'_',ftype_diags{j}]) = out.(ftypes{i}).(ftype_diags{j}); 
	end
end
