function Sim14

%% Reset
close all
clear

%% Load data
load('Groups8.mat');

%% Set names
simName = '14 Groups of 8, narrow';
folderName = 'Sim14';

%% Set conditions
[Sim.Luminaires.View] = deal('narrow');
[Sim.Zones.DimAfter] = deal(duration(0,20,0));
[Sim.Zones.OffAfter] = deal(duration(0,20,0));

[Sim, trofferMinutes] = RunSim(Sim, simName, folderName);