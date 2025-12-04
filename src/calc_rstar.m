% Calculate R* using theory
% R* = (K*D)/(y*V*K - D) under Monod kinetics

% Get R* function 
r_star_oxy = @(ftype) ((params.(ftype).K_oxy*opt.dilution*params.(ftype).y_oxy)/(params.(ftype).Vmax_oxy - opt.dilution*params.(ftype).y_oxy));
r_star_red = @(ftype) ((params.(ftype).K_red*opt.dilution*params.(ftype).y_red)/(params.(ftype).Vmax_red - opt.dilution*params.(ftype).y_red));

% OM*
rstar.om.aer = r_star_red('aer');
rstar.om.nar = r_star_red('nar');
rstar.om.nai = r_star_red('nai');
rstar.om.nao = r_star_red('nao');
rstar.om.nir = r_star_red('nir');
rstar.om.nio = r_star_red('nio');
rstar.om.nos = r_star_red('nos');

% O2*
rstar.o2.aer = r_star_oxy('aer');
rstar.o2.aoa = r_star_oxy('aoa');
rstar.o2.nob = r_star_oxy('nob');

% NO3*
rstar.no3.nar = r_star_oxy('nar');
rstar.no3.nai = r_star_oxy('nai');
rstar.no3.nao = r_star_oxy('nao');

% NO2*
rstar.no2.nob = r_star_red('nob');
rstar.no2.nir = r_star_oxy('nir');
rstar.no2.nio = r_star_oxy('nio');
rstar.no2.aox = r_star_oxy('aox');

% N2O*
rstar.n2o.nos = r_star_oxy('nos');

% NH4*
rstar.nh4.aoa = r_star_red('aoa');
rstar.nh4.aox = r_star_red('aox');

