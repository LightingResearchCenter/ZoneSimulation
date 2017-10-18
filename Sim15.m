function Sim15

%% Reset
close all
clear

%% Load data
load('Groups4.mat');

%% Set names
simName = '15 Groups of 4, narrow, 1 min delay';
folderName = 'Sim15';

%% Set conditions
[Sim.Luminaires.View] = deal('narrow');
[Sim.Zones.DimAfter] = deal(duration(0,1,0));
[Sim.Zones.OffAfter] = deal(duration(0,1,0));

[Sim, tropherMinutes] = RunSim(Sim, simName, folderName);