function Sim12

%% Reset
close all
clear

%% Load data
load('Groups2.mat');

%% Set names
simName = '12 Groups of 2, narrow';
folderName = 'Sim12';

%% Set conditions
[Sim.Luminaires.View] = deal('narrow');
[Sim.Zones.DimAfter] = deal(duration(0,20,0));
[Sim.Zones.OffAfter] = deal(duration(0,20,0));

[Sim, tropherMinutes] = RunSim(Sim, simName, folderName);