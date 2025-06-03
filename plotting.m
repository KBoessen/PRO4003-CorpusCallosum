%%baseline

%load file
load('CorpusCallosumBaseline.mat');  

%plot membrane potentials at all nodes
figure;
hold on;

numNodes = size(MEMBRANE_POTENTIAL, 2);
for i = 1:numNodes
    plot(TIME_VECTOR * 1000, MEMBRANE_POTENTIAL(:, i));  % Time in ms
end

xlabel('Time (ms)');
ylabel('Membrane Potential (mV)');
title('Action Potentials at All Nodes (Baseline Simulation)');
grid on;
hold off;

%% 100my 50Na

%load file
load('CorpusCallosum100My50Na.mat');  

%plot membrane potentials at all nodes
figure;
hold on;

numNodes = size(MEMBRANE_POTENTIAL, 2);
for i = 1:numNodes
    plot(TIME_VECTOR * 1000, MEMBRANE_POTENTIAL(:, i));  % Time in ms
end

xlabel('Time (ms)');
ylabel('Membrane Potential (mV)');
title('Action Potentials at All Nodes (Myelin 100, Na 50)');
grid on;
hold off;

%% 100my 150Na

%load file
load('CorpusCallosum100My150Na.mat'); 

%plot membrane potentials at all nodes
figure;
hold on;

numNodes = size(MEMBRANE_POTENTIAL, 2);
for i = 1:numNodes
    plot(TIME_VECTOR * 1000, MEMBRANE_POTENTIAL(:, i));  % Time in ms
end

xlabel('Time (ms)');
ylabel('Membrane Potential (mV)');
title('Action Potentials at All Nodes (Myelin 100, Na 150)');
grid on;
hold off;

%% 50my 150Na

%load file
load('CorpusCallosum50My150Na.mat');  

%plot membrane potentials at all nodes
figure;
hold on;

numNodes = size(MEMBRANE_POTENTIAL, 2);
for i = 1:numNodes
    plot(TIME_VECTOR * 1000, MEMBRANE_POTENTIAL(:, i));  % Time in ms
end

xlabel('Time (ms)');
ylabel('Membrane Potential (mV)');
title('Action Potentials at All Nodes (Myelin 50, Na 150)');
grid on;
hold off;