close all
clear
clc

% Set file directory
dataDir = 'C:\Users\jonesg5\Dropbox\NYSERDA loggers\CSV files';

% Read excel table
T = readtable('Hobo start dates.xlsx');

% Construct full file paths
T.Path = fullfile(dataDir,T.File);
T = T(:,[end,1:end-1]);

% Extract meta data from file name
pattern = '^NYSERDA_(.*),(.*)_(.*_cone)_(\d{4})\.csv$';
r = regexp(T.File, pattern, 'tokens');
r = vertcat(r{:});
r = vertcat(r{:});

% Format meta data
r = regexprep(r,'no_cone','wide');
r = regexprep(r,'with_cone','narrow');
T.ConsecutiveRecording = strcmpi(T.ConsecutiveRecording, 'Yes');

% Save meta data to table
T.Position = horzcat( str2double(r(:,1)), str2double(r(:,2)) );
T.View = r(:,3);
T.ID = r(:,4);

% Construct objects from source data
Sim = Simulation;
% Import sensor data
for iS = 1:height(T)
    Sim.Sensors(iS,1) = Sensor;
    Sim.Sensors(iS,1).import(T.Path{iS}, T.Position(iS,:), T.View{iS}, T.ID{iS}, T.StartDate(iS), T.ConsecutiveRecording(iS));
end
% Associate sensors with luminaires
p = unique(T.Position,'rows');
for iL = 1:length(p)
    Sim.Luminaires(iL,1) = Luminaire;
    thisPosition = p(iL,:);
    Sim.Luminaires(iL,1).Position = thisPosition;
    Sim.Luminaires(iL,1).Sensors = findobj(Sim.Sensors,'Position',p(iL,:));
    Sim.Zones(iL,1) = Zone;
    Sim.Zones(iL,1).Luminaires = Sim.Luminaires(iL,1);
end

% Save, clear, reload
save('BaseCase.mat','Sim')
clear
load('BaseCase.mat')

