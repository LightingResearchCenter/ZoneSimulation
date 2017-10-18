function Sim11

%% Reset
close all
clear

%% Load data
load('Groups8.mat');

%% Set names
simName = '11 Groups of 8, wide';
folderName = 'Sim11';

%% Set conditions
[Sim.Luminaires.View] = deal('wide');
[Sim.Zones.DimAfter] = deal(duration(0,20,0));
[Sim.Zones.OffAfter] = deal(duration(0,20,0));

[Sim, trofferMinutes] = RunSim(Sim, simName, folderName);