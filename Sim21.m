function Sim21

%% Reset
close all
clear

%% Load data
load('GroupsWOAisles.mat');

%% Set names
simName = '21 Groups without aisles, 20 min delay';
folderName = 'Sim21';

%% Set conditions
[Sim.Luminaires.View] = deal('narrow');
[Sim.Zones.DimAfter] = deal(duration(0,20,0));
[Sim.Zones.OffAfter] = deal(duration(0,20,0));

[Sim, tropherMinutes] = RunSim(Sim, simName, folderName);