function plotMembranePotentials(filename, xlim_ms)
% PLOTMEMBRANEPOTENTIALS  Plots membrane potentials at all nodes.
%
% Usage:
%   plotMembranePotentials('filename.mat');
%   plotMembranePotentials('file.mat', 5000);  % optional custom x-axis
%   limit if needed

    % Load the simulation data
    data = load(filename);
    V = data.MEMBRANE_POTENTIAL;
    t = data.TIME_VECTOR;

    % Determine number of nodes
    numNodes = size(V, 2);

    % Plot all node traces
    figure;
    hold on;
    for i = 1:numNodes
        plot(t * 1000, V(:, i));  % Time in ms
    end

    % Labels and title
    xlabel('Time (ms)');
    ylabel('Membrane Potential (mV)');
    title(sprintf('Action Potentials at All Nodes (%s)', strrep(filename, '_', '\_')));
    grid on;

    % Optional: custom x-axis limit
    if nargin > 1 && ~isempty(xlim_ms)
        xlim([0, xlim_ms]);
    else
        xlim([0, max(t) * 1000]);
    end

    hold off;
end
