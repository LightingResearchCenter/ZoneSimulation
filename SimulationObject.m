classdef (Abstract) SimulationObject < matlab.mixin.SetGet
    %SIMULATIONOBJECT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        SimRelTime = duration(0, 0, (0:60:48*60*60)')
    end
    
    methods
    end
    
end

