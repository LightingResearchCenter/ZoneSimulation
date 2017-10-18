function Outline

%% Reset
close all
clear
% clc

%% Load data
load('BaseCase.mat');

%% Set names
simName = 'Outline, narrow';
folderName = 'Outlines';

%% Make directory to save to
mkdir(folderName);

%% Set conditions
[Sim.Luminaires.View] = deal('narrow');
[Sim.Zones.DimAfter] = deal(duration(0,1,0));
[Sim.Zones.OffAfter] = deal(duration(0,1,0));

%% Render floor plan
[ax2, tBlock] = renderFloorPlan;

%% Run simulation

    Sim.Clock = Sim.SimRelTime(1);
    render(Sim, ax2);
    ts = char(Sim.Clock);
    tBlock.String = simName;
    drawnow;
    filename = fullfile(folderName,'outline narrow');
    print(filename,'-djpeg','-r200');

