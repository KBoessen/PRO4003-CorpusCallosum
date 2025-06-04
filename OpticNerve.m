% Simulating Saltatory Conduction and Sodium Channel Density Modulation 
% in a Demyelinated Optic Nerve Axon

% PRO4003 - Group B2

% Directory management
currentDirectory = fileparts(mfilename('fullpath'));
addpath(genpath(currentDirectory));
saveDirectory    = fullfile(pwd,'results');

if ~isfolder(saveDirectory)
    mkdir(saveDirectory)
end

% Retrieve parameters for Carcamo Optic Nerve model
par = Carcamo2017OpticNerveAxon();

% Run the model
fprintf('RUNNING BASELINE MODEL\n')
Model(par, fullfile(saveDirectory, 'OpticNerveBaseline.mat'));

%% Myelin wraps 50%
% Regenerate parameters for Carcamo Optic Nerve model
par = Carcamo2017OpticNerveAxon();

density = [50, 100, 150];

for i = density

% Change the resistance in the paranode periaxonal space, by modifying the width.
par.myel.geo.peri.value.vec(:, [1, end])    = 0.007719692 * par.myel.geo.numlamellae.value.ref / 4;

% Update the number of myelin wraps
par.myel.geo.numlamellae.value.vec(:) = 4;

% Update the Na channel density
par.node.elec.act(1).cond.value.ref = par.node.elec.act(1).cond.value.ref * i / 100;
par.node.elec.act(1).cond.value.vec = par.node.elec.act(1).cond.value.ref * ones(par.geo.nnode, par.geo.nnodeseg);

% Update leak conductance to maintain resting membrane potential.
par = CalculateLeakConductance(par);

% Run the model with updated parameters.
fprintf('RUNNING MODEL 50%% Myelin %i%% Density\n',i)
fileName = sprintf('OpticNerve50My%iNa.mat',i);
Model(par, fullfile(saveDirectory, fileName));

end

%% Myelin wraps 25%
% Regenerate parameters for Carcamo Optic Nerve model
par = Carcamo2017OpticNerveAxon();

density = [50, 100, 150];

for i = density

% Change the resistance in the paranode periaxonal space, by modifying the width.
par.myel.geo.peri.value.vec(:, [1, end])    = 0.007719692 * par.myel.geo.numlamellae.value.ref / 2;

% Update the number of myelin wraps
par.myel.geo.numlamellae.value.vec(:) = 2;

% Update the Na channel density
par.node.elec.act(1).cond.value.ref = par.node.elec.act(1).cond.value.ref * i / 100;
par.node.elec.act(1).cond.value.vec = par.node.elec.act(1).cond.value.ref * ones(par.geo.nnode, par.geo.nnodeseg);

% Update leak conductance to maintain resting membrane potential.
par = CalculateLeakConductance(par);

% Run the model with updated parameters.
fprintf('RUNNING MODEL 25%% Myelin %i%% Density\n',i)
fileName = sprintf('OpticNerve25My%iNa.mat',i);
Model(par, fullfile(saveDirectory, fileName));

end

%% Myelin wraps 0
% Regenerate parameters for Carcamo Optic Nerve model
par = Carcamo2017OpticNerveAxon();

density = [50, 100, 150];

for i = density

% Update the number of myelin wraps
par.myel.geo.numlamellae.value.vec(:) = 0;

% Update the Na channel density
par.node.elec.act(1).cond.value.ref = par.node.elec.act(1).cond.value.ref * i / 100;
par.node.elec.act(1).cond.value.vec = par.node.elec.act(1).cond.value.ref * ones(par.geo.nnode, par.geo.nnodeseg);

% Update leak conductance to maintain resting membrane potential.
par = CalculateLeakConductance(par);

% Run the model with updated parameters.
fprintf('RUNNING MODEL 0%% Myelin %i%% Density\n',i)
fileName = sprintf('OpticNerve0My%iNa.mat',i);
Model(par, fullfile(saveDirectory, fileName));

end

%% Plot Membrane Potentials

density = [50, 100, 150];
myelin = [0, 25, 50];

for j = myelin
    for i = density
        fileName = sprintf('OpticNerve%iMy%iNa.mat',j,i);
        plotMembranePotentials(fileName,4000);
    end
end

%% Plot Conduction Velocity

density = [50, 100, 150];
myelin = [0, 25, 50];

for j = myelin
    for i = density
        fileName = sprintf('OpticNerve%iMy%iNa.mat',j,i);
        plotConductionVelocity(fileName);
    end
end