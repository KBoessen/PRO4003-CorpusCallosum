% Simulating Saltatory Conduction and Sodium Channel Density Modulation 
% in a Demyelinated Corpus Callosum Axon

% PRO4003 - Group B2

% Directory management
currentDirectory = fileparts(mfilename('fullpath'));
addpath(genpath(currentDirectory));
saveDirectory    = fullfile(pwd,'results');

if ~isfolder(saveDirectory)
    mkdir(saveDirectory)
end

% Retrieve parameters for Bakiri Corpus Callosum model
par = Bakiri2011CorpusCallosum();

% Run the model
fprintf('RUNNING BASELINE MODEL\n')
Model(par, fullfile(saveDirectory, 'CorpusCallosumBaseline.mat'));

%% Na channel density 50%
% Regenerate parameters for Bakiri Corpus Callosum model
par = Bakiri2011CorpusCallosum();

% Reduce the Na channel density by 50%
par.node.elec.act(1).cond.value.ref = par.node.elec.act(1).cond.value.ref * 0.5;
par.node.elec.act(1).cond.value.vec = par.node.elec.act(1).cond.value.ref * ones(par.geo.nnode, par.geo.nnodeseg);

% Update leak conductance to maintain resting membrane potential.
par = CalculateLeakConductance(par);

% Run the model with updated parameters.
fprintf('RUNNING MODEL 100%% Myelin 50%% Density\n')
Model(par, fullfile(saveDirectory, 'CorpusCallosum100My50Na.mat'));

%% Na channel density 150%
% Regenerate parameters for Bakiri Corpus Callosum model
par = Bakiri2011CorpusCallosum();

% Increase the Na channel density by 50%
par.node.elec.act(1).cond.value.ref = par.node.elec.act(1).cond.value.ref * 1.5;
par.node.elec.act(1).cond.value.vec = par.node.elec.act(1).cond.value.ref * ones(par.geo.nnode, par.geo.nnodeseg);

% Update leak conductance to maintain resting membrane potential.
par = CalculateLeakConductance(par);

% Run the model with updated parameters.
fprintf('RUNNING MODEL 100%% Myelin 150%% Density\n')
Model(par, fullfile(saveDirectory, 'CorpusCallosum100My150Na.mat'));

%% Myelin wraps 50%
% Regenerate parameters for Bakiri Corpus Callosum model
par = Bakiri2011CorpusCallosum();

% Update the number of myelin wraps.
par.myel.geo.numlamellae.value.vec(:) = par.myel.geo.numlamellae.value.ref * 0.5;

% Run the model with updated parameters.
fprintf('RUNNING MODEL 50%% Myelin 150%% Density\n')
Model(par, fullfile(saveDirectory, 'CorpusCallosum50My150Na.mat'));
