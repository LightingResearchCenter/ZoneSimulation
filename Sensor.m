classdef Sensor < SimulationObject & Equipment
    %SENSOR Occupancy sensor class
    %   Detailed explanation goes here
    
    properties
        View
        Source
        Graphic
    end
    
    properties (SetAccess = protected)
        State
        RelativeTime
        MotionDetected
    end
    
    properties (Dependent, SetAccess = protected)
        Shape
    end
    
    properties (Access = private)
        ConsecutiveRecording
    end
    
    methods
        function obj = import(obj, filePath, position, view, id, startDate, consecutive)
            obj.ID = id;
            obj.View = view;
            obj.Position = position;
            obj.ConsecutiveRecording = consecutive;
            warning('off','MATLAB:table:ModifiedAndSavedVarnames');
            obj.Source = readtable(filePath,'Format','%d %{MM/dd/yy hh:mm:ss a}D %f %s %s %s %s');
            warning('on','MATLAB:table:ModifiedAndSavedVarnames')
            obj.convertSource(startDate, consecutive);
        end
        
        function shape = get.Shape(obj)
            switch obj.View
                case 'narrow'
                    r = 5.06;
                case 'wide'
                    r = 7.33;
            end
            theta = linspace(0,2*pi);
            x = r*cos(theta);
            y = r*sin(theta) + 1;
            shape = [x', y'];
        end
        
        function obj = convertSource(obj, startDate, consecutive)
            absoluteTime = obj.Source{:,2};
            motion = obj.Source{:,3};
            
            idxNan = isnan(motion);
            absoluteTime(idxNan) = [];
            motion(idxNan)       = [];
            
            if consecutive
                idxObservation = absoluteTime >= startDate & absoluteTime < dateshift(startDate,'start','day',2);
                absoluteTime = absoluteTime(idxObservation);
                relativeTime = absoluteTime - startDate;
                motion = motion(idxObservation);
            else
                idxObservation1 = absoluteTime >= startDate & absoluteTime < dateshift(startDate,'start','day',1);
                
                startDate2 = dateshift(startDate,'dayofweek','Monday');
                idxObservation2 = absoluteTime >= startDate2 & absoluteTime < dateshift(startDate2,'start','day',1);
                
                absoluteTime1 = absoluteTime(idxObservation1);
                relativeTime1 = absoluteTime1 - startDate;
                motion1 = motion(idxObservation1);
                
                absoluteTime2 = absoluteTime(idxObservation2);
                relativeTime2 = absoluteTime2 - startDate2;
                motion2 = motion(idxObservation2);
                
                relativeTime = vertcat(relativeTime1, relativeTime2);
                motion = vertcat(motion1, motion2);
            end
            
            % Ensure unique sample times priority to last repeated entry
            [C, ia, ic] = unique(seconds(relativeTime),'last','legacy');
            relativeTime = relativeTime(ia);
            motion = motion(ia);
            
            obj.RelativeTime = relativeTime;
            obj.MotionDetected = logical(motion);
            
            obj.determineState;
        end
        
        function obj = determineState(obj)
            t0 = vertcat(duration(0,0,-1), obj.RelativeTime, duration(48,0,0));
            m0 = double(vertcat(false, obj.MotionDetected, false));
            t = obj.SimRelTime;
            obj.State = logical(interp1(t0, m0, t, 'previous'));
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
            X = obj.Shape(:,1) + obj.Position(1);
            Y = obj.Shape(:,2) + obj.Position(2);
            Z = ones(size(X));
            
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
                obj.Graphic = patch(ax,'XData',X,'YData',Y,'ZData',Z,'FaceColor',[66 142 189]/255,'EdgeColor','none','FaceAlpha',.5);
            end
            
            state = obj.State(obj.SimRelTime == sim.Clock);
            if state
                obj.Graphic.Visible = 'on';
                obj.Graphic.FaceAlpha = 0.5;
            else
                obj.Graphic.Visible = 'off';
% obj.Graphic.Visible = 'on';
%                 obj.Graphic.FaceAlpha = 0;
%                 obj.Graphic.EdgeColor = [66 142 189]/255;
            end
        end
    end
    
end

