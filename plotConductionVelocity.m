function velocity_nodes_per_ms = plotConductionVelocity(filename)
% PLOTCONDUCTIONVELOCITY  Loads simulation data and plots AP peak timing
%                         across nodes, estimating conduction velocity.
%
% Usage:
%   velocity = plotConductionVelocity('filename.mat');

    % Load simulation data
    data = load(filename);
    
    % Extract variables
    V = data.MEMBRANE_POTENTIAL;
    t = data.TIME_VECTOR;
    
    % Determine number of nodes
    numNodes = size(V, 2);

    % Find time of peak voltage for each node
    [~, peakIndices] = max(V);
    peakTimes = t(peakIndices) * 1000;  % convert to ms

    % Use node index as position
    nodePositions = 1:numNodes;

    % Estimate conduction velocity via linear regression
    coeffs = polyfit(nodePositions, peakTimes, 1);
    slope = coeffs(1);
    velocity_nodes_per_ms = 1 / slope;

    % Plot
    figure;
    plot(nodePositions, peakTimes, 'o-');
    xlabel('Node Index');
    ylabel('Time of Peak Voltage (ms)');
    title(sprintf('AP Peak Timing Across Nodes\nVelocity: %.4f nodes/ms', velocity_nodes_per_ms));
    grid on;
end
