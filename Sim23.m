function Sim23

%% Reset
close all
clear

%% Load data
load('SpaceWise.mat');

%% Set names
simName = '23 Background dim level, Delay time 5 min';
folderName = 'Sim23';

%% Set conditions
[Sim.Luminaires.View] = deal('narrow');
[Sim.Zones.DimAfter] = deal(duration(0,5,0));

[Sim, tropherMinutes] = RunSim(Sim, simName, folderName);