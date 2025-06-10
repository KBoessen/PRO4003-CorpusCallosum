% Define conditions
%parameter
density = [50, 100, 150];  
myelin  = [25, 50];     

%plot
figure('Name', 'Conduction Velocity Across Myelin and Sodium Conditions', ...
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

    % Determine number of nodes
    numNodes = size(V, 2);

    % Find time of peak voltage for each node
    [~, peakIndices] = max(V);
    peakTimes = t(peakIndices);

    % Use node index as position
    nodePositions = 1:numNodes;

    % Estimate conduction velocity via linear regression
    coeffs = polyfit(nodePositions, peakTimes, 1);
    slope = coeffs(1);
    velocity_nodes_per_ms = 1 / slope;

    % Plot
    plot(nodePositions, peakTimes, 'o-');
    xlabel('Node Index');
    ylabel('Time of Peak Voltage (ms)');
    ylim([0, 4]);
    title(sprintf('Velocity: %.4f nodes/ms', velocity_nodes_per_ms));
    grid on;

            %add sodium label
            if row == 1
                title(sprintf('\\bfNa^+: %i%% \n\nVelocity: %.4f nodes/ms', i,velocity_nodes_per_ms));
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
sgtitle('Conduction Velocity Across Myelin and Sodium Channel Conditions');

exportgraphics(gcf, 'CorpusCallosum_conductionVelocityAllPlots.png');

