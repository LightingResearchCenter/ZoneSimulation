function Sim19

%% Reset
close all
clear

%% Load data
load('GroupsWOAisles.mat');

%% Set names
simName = '19 Groups without aisles, 5 min delay';
folderName = 'Sim19';

%% Set conditions
[Sim.Luminaires.View] = deal('narrow');
[Sim.Zones.DimAfter] = deal(duration(0,5,0));
[Sim.Zones.OffAfter] = deal(duration(0,5,0));

[Sim, tropherMinutes] = RunSim(Sim, simName, folderName);