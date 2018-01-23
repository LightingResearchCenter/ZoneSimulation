function Sim22

%% Reset
close all
clear

%% Load data
load('SpaceWise.mat');

%% Set names
simName = '22 Background dim level, Delay time 1 min';
folderName = 'Sim22';

%% Set conditions
[Sim.Luminaires.View] = deal('narrow');
[Sim.Zones.DimAfter] = deal(duration(0,1,0));

[Sim, tropherMinutes] = RunSim(Sim, simName, folderName);