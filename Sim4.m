function Sim4

%% Reset
close all
clear
% clc

%% Load data
load('BaseCase.mat');

%% Set names
simName = '4 Delay time 20 min, wide';
folderName = 'Sim4';

%% Make directory to save to
mkdir(folderName);

%% Set conditions
[Sim.Luminaires.View] = deal('wide');
[Sim.Zones.DimAfter] = deal(duration(0,20,0));
[Sim.Zones.OffAfter] = deal(duration(0,20,0));

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
disp('Sim4')
display(tropherMinutes)