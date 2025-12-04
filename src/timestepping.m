% Timestepping module

% -------------------------- %
%    Initialize tracers      %
% -------------------------- %
for i = 1:length(config.tracers)
    tmp.(config.tracers{i})    = zeros(1,2);
    tmp.(config.tracers{i})(1) = ic.(config.tracers{i});
end

% -------------------------- %
%    Initialize output       %
% -------------------------- %
for i = 1:length(config.tracers)
    out.(config.tracers{i}) = nan(1,length(config.his_dt));
end

% Initialize ftype diagnostics
ftype_diags = {'growth','bio','loss','limit'};
for i = 1:length(config.ftypes)
	for j = 1:length(ftype_diags)
		out.([config.ftypes{i},'_',ftype_diags{j}]) = nan(1,length(config.his_dt));
	end
end

% Initialize time record
out.time = nan(1,length(config.his_dt));

% -------------------------- %
%    Model timestepping      %
% -------------------------- %
hiscnt = 1;
if opt.display_progress
	disp(' ');
	tic
	disp('Time-stepping');
end
for i = 1:config.nt

    % Get tracer tendency array
    for j = 1:length(config.tracers)
        tr.(config.tracers{j}) = tmp.(config.tracers{j})(1);
    end

	% Prevent negatives (e.g., extinction)
	for j = 1:length(config.tracers)
		if tr.(config.tracers{j}) < ic.(config.tracers{j})
			tr.(config.tracers{j}) = ic.(config.tracers{j});
		end
	end

    % Get sources and sinks
    [sms,diag,tr] = sources_sinks(tr,params,opt);

    % Advect tracers at current timestep
    for j = 1:length(config.tracers)
        adv.(config.tracers{j}) = ...
            (opt.dilution.*inputs.(config.tracers{j})) - ...  % supply in
            (opt.dilution.*tr.(config.tracers{j}));           % advect out
    end

    % Update tracers at forward timestep
    for j = 1:length(config.tracers)
        tmp.(config.tracers{j})(2) = tr.(config.tracers{j}) + ((...
            sms.(config.tracers{j}) + ...
			adv.(config.tracers{j})).*config.dt);
    end

    % Old tracer = new tracer
    for j = 1:length(config.tracers)
        tmp.(config.tracers{j}) = tmp.(config.tracers{j})(2);
    end

    % Save history snapshots
    if ismember(i,config.his_dt)
        for j = 1:length(config.tracers)
            out.(config.tracers{j})(hiscnt) = tmp.(config.tracers{j})(1);
        end
		% Ftype diagnostics
		for j = 1:length(config.ftypes)
			for k = 1:length(ftype_diags)
				out.([config.ftypes{j},'_',ftype_diags{k}])(hiscnt) = diag.([config.ftypes{j},'_',ftype_diags{k}]);
			end
		end
		% Update time
        out.time(hiscnt) = i.*config.dt;
        hiscnt = hiscnt + 1;
    end

	% Report progress
	if opt.display_progress
		if ismember(i,config.disp_dt)
			ind = find(i == config.disp_dt);
			disp(['--',num2str(100*ind/length(config.disp_dt)),'% complete']);
		end
	end
end
if opt.display_progress
	toc
end



