% Script to produce ZNGI diagrams

% Shortcut to plot results
unpackStruct(model)

% Get time
tt = out.time ./ (86400);

% Get tracer pairs
xtracers = {'no3','no2','no2'};
ytracers = {'om' ,'om' ,'nh4'}; 

% Get colors for all functional types
ftypes = {'aer','nar','nai','nao','nir','nio','nos','aoa','nob','aox'};
fclrs = colormix(length(ftypes),{'w','k'});

% Initialize figure
for i = 1:length(xtracers)
	fig = piofigs('sfig',1);
	hold on; grid on; box on;
	% Plot model trajectory
	plot([ic.(xtracers{i}) out.(xtracers{i})],[ic.(ytracers{i}) out.(ytracers{i})],'-k','linewidth',1);
	legend_entries = [];
	legend_entries{1} = 'model';
	% Get limits
	xl = get(gca,'XLim');
	yl = get(gca,'YLim');
	% Get R*
	if isfield(rstar,xtracers{i})
		ffx = fields(rstar.(xtracers{i}));
	else
		ffx = [];
	end
	if isfield(rstar,ytracers{i})
		ffy = fields(rstar.(ytracers{i}));
	else
		ffy = [];
	end
	for j = 1:length(ffx)
		ind = find(strcmp(ffx{j},ftypes)==1);
		plot([rstar.(xtracers{i}).(ffx{j}) rstar.(xtracers{i}).(ffx{j})],[yl(1) yl(2)],...
			'-','color',fclrs(ind,:),'linewidth',0.5);
		legend_entries{end+1} = [xtracers{i},'* (',ffx{j},')'];
	end
	for j = 1:length(ffy)
		ind = find(strcmp(ffy{j},ftypes)==1);
		plot([xl(1) xl(2)],[rstar.(ytracers{i}).(ffy{j}) rstar.(ytracers{i}).(ffy{j})],...
			'-','color',fclrs(ind,:),'linewidth',0.5);
		legend_entries{end+1} = [ytracers{i},'* (',ffy{j},')'];
	end
	l = legend(legend_entries,'location','northeast','interpreter','latex');
	l.ItemTokenSize = [5 3];
    l.Box = 'on';
    l.AutoUpdate = 'off';
    l.FontSize = 4;
			
	% Finish
	xlbl = find(strcmp(xtracers{i},config.tracers)==1);
	ylbl = find(strcmp(ytracers{i},config.tracers)==1);
	xlabel([config.titles{xlbl},' (',config.units{xlbl},')'],'Interpreter','Latex');
	ylabel([config.titles{ylbl},' (',config.units{ylbl},')'],'Interpreter','Latex');
	set(gca,'FontSize',8);
	box on

	% Print
	export_fig('-png',['plots/ZNGI_',num2str(i)],'-m5');
	close all
end

clearvars -except model
