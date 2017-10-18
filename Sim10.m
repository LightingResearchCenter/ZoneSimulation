function Sim10

%% Reset
close all
clear

%% Load data
load('Groups4.mat');

%% Set names
simName = '10 Groups of 4, wide';
folderName = 'Sim10';

%% Set conditions
[Sim.Luminaires.View] = deal('wide');
[Sim.Zones.DimAfter] = deal(duration(0,20,0));
[Sim.Zones.OffAfter] = deal(duration(0,20,0));

[Sim, tropherMinutes] = RunSim(Sim, simName, folderName);