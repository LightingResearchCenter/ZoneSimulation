function Sim17

%% Reset
close all
clear

%% Load data
load('Groups4.mat');

%% Set names
simName = '17 Groups of 4, narrow, 10 min delay';
folderName = 'Sim17';

%% Set conditions
[Sim.Luminaires.View] = deal('narrow');
[Sim.Zones.DimAfter] = deal(duration(0,10,0));
[Sim.Zones.OffAfter] = deal(duration(0,10,0));

[Sim, tropherMinutes] = RunSim(Sim, simName, folderName);