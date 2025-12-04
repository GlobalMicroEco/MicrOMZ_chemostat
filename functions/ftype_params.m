% -------------------------- %
%       Set parameters       %
% -------------------------- %
% AER (aerobic heterotroph)
params.aer.Vmax_oxy = (2.3148e-05);
params.aer.Vmax_red = (2.4769e-05);
params.aer.K_oxy = 0.2; % diffusive 
params.aer.K_red = 20;
params.aer.y_oxy = 4.00; 
params.aer.y_red = 4.28;
params.aer.e_nh4 = 0.39;
params.aer.red = 'om';
params.aer.oxy = 'o2';
% NAR (NO3 to NO2 heterotroph)
params.nar.Vmax_oxy = (2.3148e-05);
params.nar.Vmax_red = (2.4769e-05);
params.nar.K_oxy = 1; % default 5
params.nar.K_red = 20;
params.nar.y_oxy = 12.05; 
params.nar.y_red = 6.01;
params.nar.e_no2 = 12.05;
params.nar.e_nh4 = 0.62;
params.nar.red = 'om';
params.nar.oxy = 'no3';
% NAI (NO3 to N2O heterotroph)
params.nai.Vmax_oxy = (2.3148e-05);
params.nai.Vmax_red = (2.4769e-05);
params.nai.K_oxy = 1; % default 5
params.nai.K_red = 20;
params.nai.y_oxy = 6.22; 
params.nai.y_red = 6.18;
params.nai.e_n2o = 3.11;
params.nai.e_nh4 = 0.65;
params.nai.red = 'om';
params.nai.oxy = 'no3';
% NAO (NO3 to N2 heterotroph)
params.nao.Vmax_oxy = (2.3148e-05);
params.nao.Vmax_red = (2.4769e-05);
params.nao.K_oxy = 1; % default 5
params.nao.K_red = 20;
params.nao.y_oxy = 5.50; 
params.nao.y_red = 6.72;
params.nao.e_n2  = 2.75;
params.nao.e_nh4 = 0.72;
params.nao.red = 'om';
params.nao.oxy = 'no3';
% NIR (NO2 to N2O heterotroph)
params.nir.Vmax_oxy = (2.3148e-05);
params.nir.Vmax_red = (2.4769e-05);
params.nir.K_oxy = 1; % default 5
params.nir.K_red = 20;
params.nir.y_oxy = 8.75;
params.nir.y_red = 4.6;
params.nir.e_n2o = 4.375;
params.nir.e_nh4 = 0.43;
params.nir.red = 'om';
params.nir.oxy = 'no2';
% NIO (NO2 to N2 heterotroph)
params.nio.Vmax_oxy = (2.3148e-05);
params.nio.Vmax_red = (2.4769e-05);
params.nio.K_oxy = 1; % default 5
params.nio.K_red = 20;
params.nio.y_oxy = 6.07;
params.nio.y_red = 4.7531;
params.nio.e_n2  = 3.035;
params.nio.e_nh4 = 0.45;
params.nio.red = 'om';
params.nio.oxy = 'no2';
% NOS (N2O to N2 heterotroph)
params.nos.Vmax_oxy = (2.3148e-05);
params.nos.Vmax_red = (2.4769e-05);
params.nos.K_oxy = 0.4; % diffusive 
params.nos.K_red = 20;
params.nos.y_oxy = 5.54;
params.nos.y_red = 3.22;
params.nos.e_n2  = 5.54;
params.nos.e_nh4 = 0.24;
params.nos.red = 'om';
params.nos.oxy = 'n2o';
% AOA (NH4 to NO2 chemoautotroph)
params.aoa.Vmax_oxy = (1.2668e-04);
params.aoa.Vmax_red = (9.4482e-05);
params.aoa.K_oxy = 0.333; % Bristow 2016 
params.aoa.K_red = 0.134; % Bristow 2016
params.aoa.y_oxy = 8.16;
params.aoa.y_red = 10.95;
params.aoa.e_no2 = 7.96;
params.aoa.red = 'nh4';
params.aoa.oxy = 'o2';
% NOB (NH4 to NO2 chemoautotroph)
params.nob.Vmax_oxy = (1.2043e-04);
params.nob.Vmax_red = (2.7557e-04);
params.nob.K_oxy = 0.778; % Bristow 2016 
params.nob.K_red = 0.254; % Bristow 2016
params.nob.y_oxy = 6.94;
params.nob.y_red = 15.87;
params.nob.e_no3 = 15.87;
params.nob.red = 'no2';
params.nob.oxy = 'o2';
% AMX
params.aox.Vmax_oxy = 5.1244e-05;
params.aox.Vmax_red = 4.3287e-05;
params.aox.K_oxy = 0.45;
params.aox.K_red = 0.45;
params.aox.y_oxy = 17.71;
params.aox.y_red = 14.96;
params.aox.e_no3 = 2.57;
params.aox.e_n2  = 14.95;
params.aox.red = 'nh4';
params.aox.oxy = 'no2';
