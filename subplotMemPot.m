% Define conditions
%parameter
density = [50, 100, 150];  
myelin  = [0, 25, 50];     

%plot
figure('Name', 'APs Across Myelin and Sodium Conditions', ...
       'Units', 'normalized', 'Position', [0.1, 0.1, 0.8, 0.8]);

for row = 1:length(myelin)
    for col = 1:length(density)

        j = myelin(row);
        i = density(col);
        fileName = sprintf('CorpusCallosum%iMy%iNa.mat', j, i);

        %subplot position index
        idx = (row - 1) * length(density) + col;
        ax = subplot(length(myelin), length(density), idx);
        hold on;

        try
            % Load data
            data = load(fileName);
            V = data.MEMBRANE_POTENTIAL;
            t = data.TIME_VECTOR;

            % Plot each node
            for n = 1:size(V, 2)
                plot(t * 1000, V(:, n));  %convert to ms
            end

            % Axis settings
            xlim([0, max(t) * 1000]);
            ylim([-100, 50]);
            xlabel('Time (ms)');
            ylabel('Vm (mV)');
            grid on;

            %add sodium label
            if row == 1
                title(sprintf('\\bfNa^+: %i%%', i));
            end

            %add myelin label
            if col == 1
                text(-0.25, 0.5, sprintf('Myelin: %i%%', j), ...
                    'Units', 'normalized', ...
                    'Rotation', 90, ...
                    'HorizontalAlignment', 'center', ...
                    'VerticalAlignment', 'middle', ...
                    'FontWeight', 'bold', ...
                    'FontSize', 10);
            end

        catch ME
            warning('Could not process %s: %s', fileName, ME.message);
        end

        hold off;
    end
end

% Overall figure title
sgtitle('Action Potentials Across Myelin and Sodium Channel Conditions');

