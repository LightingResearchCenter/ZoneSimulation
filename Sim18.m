function Sim18

%% Reset
close all
clear

%% Load data
load('GroupsWOAisles.mat');

%% Set names
simName = '18 Groups without aisles, 1 min delay';
folderName = 'Sim18';

%% Set conditions
[Sim.Luminaires.View] = deal('narrow');
[Sim.Zones.DimAfter] = deal(duration(0,1,0));
[Sim.Zones.OffAfter] = deal(duration(0,1,0));

[Sim, tropherMinutes] = RunSim(Sim, simName, folderName);