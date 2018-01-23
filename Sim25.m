function Sim25

%% Reset
close all
clear

%% Load data
load('SpaceWise.mat');

%% Set names
simName = '25 Background dim level, Delay time 20 min';
folderName = 'Sim25';

%% Set conditions
[Sim.Luminaires.View] = deal('narrow');
[Sim.Zones.DimAfter] = deal(duration(0,20,0));

[Sim, tropherMinutes] = RunSim(Sim, simName, folderName);