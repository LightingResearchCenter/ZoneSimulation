function Sim13

%% Reset
close all
clear

%% Load data
load('Groups4.mat');

%% Set names
simName = '13 Groups of 4, narrow';
folderName = 'Sim13';

%% Set conditions
[Sim.Luminaires.View] = deal('narrow');
[Sim.Zones.DimAfter] = deal(duration(0,20,0));
[Sim.Zones.OffAfter] = deal(duration(0,20,0));

[Sim, tropherMinutes] = RunSim(Sim, simName, folderName);