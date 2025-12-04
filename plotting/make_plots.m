% Make figures
warning off

% Shortcut to plot results
unpackStruct(model)

% Get time
tt = out.time ./ (86400);
ttend = config.years2plot*365;

% Constant results
for i = 1:length(config.tracers)
	% Get rstar fields
	ffclrs = [];
	ff = [];
	if isfield(rstar,config.tracers{i});
		ff = fields(rstar.(config.tracers{i}));
		ffclrs = colormix(length(ff),{'w','k'});
	end
	% Initiate figure
	fig = piofigs('sfig',0.33);
	hold on; grid on; box on;
	plot(tt,out.(config.tracers{i}),'-','color',rgb('Black'),'linewidth',1);
	legend_entries = [];
	legend_entries{1} = config.titles{i};
	xlim([0 ttend+1]);
	xl = get(gca,'XLim');
	if ~isempty(ff)
		for j = 1:length(ff)
			plot([xl(1) xl(2)],[rstar.(config.tracers{i}).(ff{j}) rstar.(config.tracers{i}).(ff{j})],...
				'--','color',ffclrs(j,:),'linewidth',0.5);
			legend_entries{end+1} = ['$R^*$ (',ff{j},')'];
		end
	end
	if length(legend_entries)<=5
		l = legend([legend_entries],'location','north','Interpreter','Latex','orientation','horizontal',...
			'NumColumns',5);
	else
		l = legend([legend_entries],'location','north','Interpreter','Latex','orientation','horizontal',...
			'NumColumns',4);
	end
	l.ItemTokenSize = [5 3];
	l.Box = 'off';
	l.AutoUpdate = 'off';
	l.FontSize = 4;
	xlabel('Model days','Interpreter','Latex');
	ylabel(config.units{i},'Interpreter','Latex');
	grid on
	title([config.titles{i}],'Interpreter','Latex');
	yl = get(gca,'YLim');
	set(gca,'YLim',[0 yl(2)*1.5]);
	set(gca,'FontSize',8);
	export_fig('-png',['plots/',config.tracers{i}],'-m5');
	close all
end

clearvars -except model
