classdef Simulation < SimulationObject
    %SIMULATION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Zones       Zone
        Luminaires	Luminaire
        Sensors     Sensor
        Clock
        isSynced = false
    end
    
    methods
        function obj = set.Clock(obj, clock)
            obj.Clock = clock;
        end
        
        function render(obj, varargin)
            if ~obj.isSynced
                generateState(obj.Zones);
                obj.isSynced = true;
            end
            
            if nargin == 2
                render(vertcat(obj.Zones), obj, varargin{1});
            else
                render(vertcat(obj.Zones), obj);
            end
        end
    end
    
end

