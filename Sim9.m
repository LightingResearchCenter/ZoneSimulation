function Sim9

%% Reset
close all
clear

%% Load data
load('Groups2.mat');

%% Set names
simName = '9 Groups of 2, wide';
folderName = 'Sim9';

%% Set conditions
[Sim.Luminaires.View] = deal('wide');
[Sim.Zones.DimAfter] = deal(duration(0,20,0));
[Sim.Zones.OffAfter] = deal(duration(0,20,0));

[Sim, tropherMinutes] = RunSim(Sim, simName, folderName);