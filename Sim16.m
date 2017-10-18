function Sim16

%% Reset
close all
clear

%% Load data
load('Groups4.mat');

%% Set names
simName = '16 Groups of 4, narrow, 5 min delay';
folderName = 'Sim16';

%% Set conditions
[Sim.Luminaires.View] = deal('narrow');
[Sim.Zones.DimAfter] = deal(duration(0,5,0));
[Sim.Zones.OffAfter] = deal(duration(0,5,0));

[Sim, tropherMinutes] = RunSim(Sim, simName, folderName);