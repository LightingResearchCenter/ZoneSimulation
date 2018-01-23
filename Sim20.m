function Sim20

%% Reset
close all
clear

%% Load data
load('GroupsWOAisles.mat');

%% Set names
simName = '20 Groups without aisles, 10 min delay';
folderName = 'Sim20';

%% Set conditions
[Sim.Luminaires.View] = deal('narrow');
[Sim.Zones.DimAfter] = deal(duration(0,10,0));
[Sim.Zones.OffAfter] = deal(duration(0,10,0));

[Sim, tropherMinutes] = RunSim(Sim, simName, folderName);