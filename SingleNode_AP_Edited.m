% Simulating Saltatory Conduction and Sodium Channel Density Modulation 
% in a Demyelinated Corpus Callosum Axon

% PRO4003 - Group B2
% Directory management

cd('D:\UM\Project 2\PRO4003-master\PRO4003-master')
% Directory management
currentDirectory = fileparts(mfilename('fullpath'));
addpath(genpath(currentDirectory));
saveDirectory    = fullfile(pwd,'results');

if ~isfolder(saveDirectory)
    mkdir(saveDirectory)
end

% Na channel density 50%
% Regenerate parameters for Bakiri Corpus Callosum model
par = Bakiri2011CorpusCallosum();

target_nodes = [5 6 7];

N = 21; % example number of nodes
par.node.elec.act(1).cond.value.ref = ones(1, N)*30;  % or zeros(1, N)

% Then you can safely apply the scaling
par.node.elec.act(1).cond.value.ref(target_nodes) = ...
    par.node.elec.act(1).cond.value.ref(target_nodes) * 1.5;

% Reduce the Na channel density by 50%

par.node.elec.act(1).cond.value.vec(target_nodes, :) = ...
    par.node.elec.act(1).cond.value.ref(target_nodes) .* ones(1, par.geo.nnodeseg);

% Myelin wraps 50%
par.myel.geo.numlamellae.value.vec(target_nodes) = 3;

% Update leak conductance to maintain resting membrane potential.
par = CalculateLeakConductance(par);

% Run the model with updated parameters.
fprintf('RUNNING MODEL 50%% Myelin 150%% Density at nodes 5 to 7\n')
Model(par, fullfile(saveDirectory, 'CorpusCallosum50Mye150Na_nodes5to7.mat'));

%% Plotting

load('CorpusCallosum50Mye150Na_nodes5to7.mat');  
%plot membrane potentials at all nodes
figure;
hold on;

numNodes = size(MEMBRANE_POTENTIAL, 2);
for i = 1:numNodes
    plot(TIME_VECTOR * 1000, MEMBRANE_POTENTIAL(:, i));  % Time in ms
end

xlabel('Time (ms)');
ylabel('Membrane Potential (mV)');
title('Action Potentials at All Nodes (Myelin 50, Na 150, Nodes 5 to 7)');
grid on;
hold off;

