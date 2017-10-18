classdef Zone < SimulationObject
    %ZONE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        ID
        Luminaires Luminaire
        Perimeter
        DimLevel = 0.5
        DimAfter = duration(0,15,0)
        OffAfter = duration(0,20,0)
    end
    properties (SetAccess = protected)
        State
    end
    
    methods
        function generateState(obj)
            
            arrayfun(@pGenState, obj)
            
            function pGenState(obj)
                sensorHandles = vertcat(obj.Luminaires.ActiveSensor);
                sensorState = any(horzcat(sensorHandles.State), 2);
                state = sensorState;
                
                epoch = mode(diff(obj.SimRelTime));
                nDim = round(obj.DimAfter/epoch);
                nOff = round(obj.OffAfter/epoch);
                nPad = nOff;
                
                statePad = vertcat(false(nPad,1), state, false(nPad,1));
                stateShift = false(numel(statePad), nOff);
                
                for iS = 1:nOff
                    stateShift(:,iS) = circshift(statePad, iS);
                end
                
                stateShift(1+end-nPad:end,:) = [];
                stateShift(1:nPad,:) = [];
                
                stateA = any(stateShift(:,1:nDim),2);
                stateB = any(stateShift(:,nDim+1:nOff),2);
                
                stateOn  = state | stateA;
                stateDim = ~stateOn & stateB;
                
                state = double(stateOn);
                state(stateDim) = obj.DimLevel;
                
                tOff = obj.SimRelTime(~state);
                for iT = 1:numel(tOff)
                    t = tOff(iT);
                    if any(sensorState(obj.SimRelTime < t & obj.SimRelTime > t-obj.DimAfter))
                        state(obj.SimRelTime == t) = 1;
                    elseif any(sensorState(obj.SimRelTime < t & obj.SimRelTime > t-obj.OffAfter))
                        state(obj.SimRelTime == t) = obj.DimLevel;
                    end
                end
                
                obj.State = state;
                obj.syncLuminaires;
            end
        end
        
        function syncLuminaires(obj)
            arrayfun(@(o)pSync(o),obj)
            
            function pSync(aZone)
                arrayfun(@(o)pSet(o, aZone.State), aZone.Luminaires);
            end
            
            function pSet(aLuminaire, thisState)
                aLuminaire.State = thisState;
            end
        end
        
        function render(obj, sim, varargin)
            if nargin == 3
                render(vertcat(obj.Luminaires), sim, varargin{1});
            else
                render(vertcat(obj.Luminaires), sim);
            end
        end
    end
    
end

