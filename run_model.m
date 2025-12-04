function [model] = run_model(opt)
% ----------------------------------------------------------------
% Very simple model to simulate bacterial growth
%
% Usage:
%	- [model] = run_model(opt)
%
% Inputs:
%	- opt = options loaded from options.m, or from options_suite.m
% ------------------------------------------------------------------
addpath functions
addpath src

if nargin<1
	% Load default options
	options
end

% Display settings
if opt.display_progress
	disp(' ');
	disp(['Amplitude (h) = ',num2str(opt.amplitude),' (mmol OM m^-3)']);
	disp(['Period (T)    = ',num2str(opt.period),' (days)']);
	disp(['Dilution (D)  = ',num2str(opt.dilution.*86400),' (per day)']);
end

% -------------------------- %
%       Initialize model     %
% -------------------------- %
init_model
calc_rstar

% -------------------------- %
%        Timestepping        %
% -------------------------- %
timestepping

% -------------------------- %
%       Organize output      %
% -------------------------- %
model.out     = out;
model.inputs  = inputs; 
model.ic      = ic;
model.params  = params;
model.opt     = opt;
model.config  = config;
model.pulse   = pulse;
model.rstar   = rstar;

% -------------------------- %
%         Save output        %
% -------------------------- %
if opt.save
	save('output/model.mat','model');
end

% -------------------------- %
%            Plots           %
% -------------------------- %
cd plotting
if model.opt.plots
	make_plots
end
if model.opt.zngi
	make_zngi
end
cd ../
clearvars -except model
