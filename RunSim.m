function [Sim, trofferMinutes] = RunSim(Sim, simName, folderName)
%RUNSIM Summary of this function goes here
%   Detailed explanation goes here
%% Make directory to save to

mkdir(folderName);

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
trofferMinutes = sum(superState);
disp(folderName)
display(trofferMinutes)

end

