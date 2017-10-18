function Sim5

%% Reset
close all
clear
% clc

%% Load data
load('BaseCase.mat');

%% Set names
simName = '5 Delay time 1 min, narrow';
folderName = 'Sim5';

%% Make directory to save to
mkdir(folderName);

%% Set conditions
[Sim.Luminaires.View] = deal('narrow');
[Sim.Zones.DimAfter] = deal(duration(0,1,0));
[Sim.Zones.OffAfter] = deal(duration(0,1,0));

%% Render floor plan
[ax2, tBlock] = renderFloorPlan;

%% Run simulation
for iC = 1:numel(Sim.SimRelTime)
    Sim.Clock = Sim.SimRelTime(iC);
    render(Sim, ax2);
    ts = char(Sim.Clock);
    tBlock.String = {['Simulation: ',simName];['Time Stamp ',ts]};
    drawnow;
    filename = fullfile(folderName,regexprep(ts,':','-'));
    print(filename,'-djpeg','-r200');
end

%% Analyze simulation
superState = vertcat(Sim.Luminaires.State);
tropherMinutes = sum(superState == 1);
disp('Sim5')
display(tropherMinutes)