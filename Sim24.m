function Sim24

%% Reset
close all
clear

%% Load data
load('SpaceWise.mat');

%% Set names
simName = '24 Background dim level, Delay time 10 min';
folderName = 'Sim24';

%% Set conditions
[Sim.Luminaires.View] = deal('narrow');
[Sim.Zones.DimAfter] = deal(duration(0,10,0));

[Sim, tropherMinutes] = RunSim(Sim, simName, folderName);