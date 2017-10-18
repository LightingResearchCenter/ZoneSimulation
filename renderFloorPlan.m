function [ax2, tBlock] = renderFloorPlan
%RENDERFLOORPLAN Summary of this function goes here
%   Detailed explanation goes here

floorPlanCData = imread('NYSERDA 2ndFloor cropped marked 2683x6313px.jpg');

%% Create figure and render floor plan
[floorPlanY,floorPlanX,~] = size(floorPlanCData);
% Create and format figure
g = groot;
g.Units = 'pixels';
scale = 1/7;
f = figure;
f.ToolBar = 'none';
f.Units = 'pixels';
f.Position(1) = (g.ScreenSize(3)-scale*floorPlanX)/2;
f.Position(2) = (g.ScreenSize(4)-scale*(floorPlanY+300))/2;
f.Position(3) = scale*floorPlanX;
f.Position(4) = scale*(floorPlanY+300);
% Create and format axes
ax = axes;
ax.Units = 'pixels';
ax.Position = scale*[0, 300, floorPlanX, floorPlanY];
ax.XLim = [0, floorPlanX];
ax.YLim = [0, floorPlanY];
% Render image to axes
floorPlanImage = image(ax, floorPlanCData);
ax.Visible = 'off';
% Create second axes
x0 = 200;
y0 = 1096;
pixel2feet = 1/(.97*38.9);
ax2 = axes;
ax2.Units = 'pixels';
ax2.Position = scale*[0, 300, floorPlanX, floorPlanY];
ax2.XLim = pixel2feet*[-x0, floorPlanX-x0];
ax2.YLim = pixel2feet*[-y0, floorPlanY-y0];
ax2.Color = 'none';
ax2.XAxisLocation = 'origin'; % Remove
ax2.YAxisLocation = 'origin'; % Remove
ax2.Visible = 'off';
hold on
% Render title block
tBlock = annotation('textbox','Units','pixels','Position', scale*[0, 0, floorPlanX, 300]);
tBlock.EdgeColor = 'none';
tBlock.BackgroundColor = 'white';
tBlock.HorizontalAlignment = 'center';
tBlock.VerticalAlignment = 'middle';
tBlock.FitBoxToText = 'off';
tBlock.Interpreter = 'none';
tBlock.String = {'Simulation: ';'Time Stamp --:--:--'};

end

