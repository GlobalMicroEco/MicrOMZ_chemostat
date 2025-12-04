% -------------------------- %
%         Switches           %
% -------------------------- %
% Default variable OM supply settings
% Vary these to introduce oscillating OM supply to model
opt.amplitude = 0;          % (mmol OM m-3)
opt.period    = (365/12);   % (days per cycle)

% Default dilution rate
opt.dilution = 0.12/86400; % (1/s)

% Default switch to display progress of run
opt.display_progress = true;

% Default switch to save model
opt.save = true;

% Default settings for input to chemostat
opt.inputs.om  = 10; % need some OM supply for any heterotrophs
opt.inputs.o2  = 0;  % set to 0 for anoxic chemostat 
opt.inputs.no3 = 30; % need some NO3 supply to start denitrification
opt.inputs.no2 = 0;  % generate internally
opt.inputs.nh4 = 0;  % generate internally
opt.inputs.n2o = 0;  % generate internally
opt.inputs.n2  = 0;  % generate internally
opt.inputs.aer = 0;  % generate internally
opt.inputs.nar = 0;  % generate internally
opt.inputs.nai = 0;  % generate internally
opt.inputs.nao = 0;  % generate internally
opt.inputs.nir = 0;  % generate internally
opt.inputs.nio = 0;  % generate internally
opt.inputs.nos = 0;  % generate internally
opt.inputs.aoa = 0;  % generate internally
opt.inputs.nob = 0;  % generate internally
opt.inputs.aox = 0;  % generate internally

% Default switch to turn on or off specific functional types
opt.aer = true; % aerobic hetero
opt.nar = true; % NO3 to NO2 hetero
opt.nai = true; % NO3 to N2O hetero
opt.nao = true; % NO3 to N2 hetero
opt.nir = true; % NO2 to N2O hetero
opt.nio = true; % NO2 to N2 hetero
opt.nos = true; % N2O to N2 hetero
opt.aoa = true; % NH4 to NO2 chemo
opt.nob = true; % NO2 to NO3 chemo
opt.aox = true; % NH4 + NO2 to N2 chemo

% Default switches to plot results
opt.plots = true;
opt.zngi  = true;

