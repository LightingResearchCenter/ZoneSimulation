function Sim2

%% Reset
close all
clear
% clc

%% Load data
load('BaseCase.mat');

%% Set names
simName = '2 Delay time 5 min, wide';
folderName = 'Sim2';

%% Make directory to save to
mkdir(folderName);

%% Set conditions
[Sim.Luminaires.View] = deal('wide');
[Sim.Zones.DimAfter] = deal(duration(0,5,0));
[Sim.Zones.OffAfter] = deal(duration(0,5,0));

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
disp('Sim2')
display(tropherMinutes)