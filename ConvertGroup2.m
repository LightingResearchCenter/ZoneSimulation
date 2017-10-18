close all
clear
clc

% Set file directory
dataDir = 'C:\Users\jonesg5\Dropbox\NYSERDA loggers\CSV files';

% Read excel table
T = readtable('Hobo start dates.xlsx');
ZT = readtable('\\root\public\snydej7\zone size project\simulation list.xlsx','Sheet','groups of 2');
ZT(isnan(ZT.Zone),:) = [];

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
end

% Associate luminaires with zones
for iZ = 1:height(ZT)
    Sim.Zones(iZ,1) = Zone;
    Sim.Zones(iZ,1).ID = num2str(ZT.Zone(iZ));
    
    thisPosition = [ZT.Troffer_1_x(iZ), ZT.Troffer_1_y(iZ)];
    if ~any(isnan(thisPosition))
        Sim.Zones(iZ,1).Luminaires(1,1) = findobj(Sim.Luminaires,'Position',thisPosition);
    end
    
    thisPosition = [ZT.Troffer_2_x(iZ), ZT.Troffer_2_y(iZ)];
    if ~any(isnan(thisPosition))
        Sim.Zones(iZ,1).Luminaires(2,1) = findobj(Sim.Luminaires,'Position',thisPosition);
    end
end

% Save, clear, reload
save('Groups2.mat','Sim')
clear
load('Groups2.mat')

