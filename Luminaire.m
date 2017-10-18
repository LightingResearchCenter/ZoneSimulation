classdef Luminaire < SimulationObject & Equipment
    %LUMINAIRE Luminaire class
    %   Detailed explanation goes here
    
    properties
        Sensors Sensor
        View = 'narrow'
        Orientation = 'landscape'
        Graphic
        State
    end
    
    properties (Dependent, SetAccess = protected)
        ActiveSensor
        Shape
    end
    
    methods
        function sensor = get.ActiveSensor(obj)
            sensor = findobj(obj.Sensors, 'View', obj.View);
        end
        
        function shape = get.Shape(obj)
            switch obj.Orientation
                case 'landscape'
                    h = 2;
                    w = 4;
                case 'portrait'
                    h = 4;
                    w = 2;
            end
            
            x = w*[0, 0, 1, 1]';
            y = h*[0, 1, 1, 0]';
            shape = [x,y];
        end
        
        function render(obj, sim, varargin)
            if nargin == 3
                arrayfun(@(o)prender(o, sim, varargin{1}),obj);
            else
                arrayfun(@(o)prender(o, sim),obj);
            end
        end
    end
    
    methods (Access = private)
        function prender(obj, sim, varargin)
            if nargin == 3
                render(obj.ActiveSensor, sim, varargin{1});
            else
                render(obj.ActiveSensor, sim);
            end
            
            X = obj.Shape(:,1) + obj.Position(1);
            Y = obj.Shape(:,2) + obj.Position(2);
            Z = 2*ones(size(X));
            
            if nargin == 3
                ax = varargin{1};
            else
                ax = gca;
            end
            
            if isgraphics(obj.Graphic)
                obj.Graphic.XData = X;
                obj.Graphic.YData = Y;
                obj.Graphic.ZData = Z;
            else
                obj.Graphic = patch(ax,'XData',X,'YData',Y,'ZData',Z,'FaceColor','yellow','EdgeColor','black');
            end
            
            state = obj.State(obj.SimRelTime == sim.Clock);
            if state == 1
                obj.Graphic.FaceColor = [255 255 0]/255;
                obj.Graphic.FaceAlpha = 1;
            elseif state == 0
                obj.Graphic.FaceColor = 'black';
                obj.Graphic.FaceAlpha = 0;
            else
                obj.Graphic.FaceColor = state*[255 255 0]/255;
                obj.Graphic.FaceAlpha = 0.75;
            end
        end
    end
    
end

