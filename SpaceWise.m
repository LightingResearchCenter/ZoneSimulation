classdef SpaceWise < SimulationObject
    %ZONE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        ID
        Luminaires Luminaire
        Perimeter
        DimLevel = 0.2
        DimAfter = duration(0,15,0)
    end
    
    methods
        function generateState(obj)
            
            arrayfun(@pGenState, obj)
            
            function pGenState(obj)
                
                
                % Determine if individual luminaires should be on 100%
                onLuminaires(obj)
                
                obj.dimLuminaires;
            end
        end
        
        function onLuminaires(obj)
            arrayfun(@(o)pOn(o),obj);
            
            function pOn(aZone)
                % Convert durations to number of points
                epoch = mode(diff(aZone.SimRelTime));
                nPad = round(aZone.DimAfter/epoch);
                
                arrayfun(@(o)pSet(o, nPad), aZone.Luminaires);
            end
            
            function pSet(aLuminaire, nPad)
                % Get sensor state
                sensorState = aLuminaire.ActiveSensor.State;
                % Pad sensor state
                statePad = vertcat(false(nPad,1), sensorState, false(nPad,1));
                % Shift sensor state in accordance with delay
                stateShift = false(numel(statePad), nPad);
                for iS = 1:nPad
                    stateShift(:,iS) = circshift(statePad, iS);
                end
                % Remove padding
                stateShift(1+end-nPad:end,:) = [];
                stateShift(1:nPad,:) = [];
                % Collapse shifted sensor state
                stateA = any(stateShift(:,1:nPad),2);
                % Combine shifted state with original and assign to
                % luminaire
                aLuminaire.State = double(sensorState | stateA);
            end
        end
        
        function dimLuminaires(obj)
            arrayfun(@(o)pSync(o),obj);
            
            function pSync(aZone)
                % Determine if any luminaires are on
                % Extract individual luminaire states
                luminaireHandles = vertcat(aZone.Luminaires);
                luminaireStates = horzcat(luminaireHandles.State);
                % Collapse luminaire states
                anyLuminaire = any(luminaireStates,2);
                
                arrayfun(@(o)pSet(o, anyLuminaire, aZone.DimLevel), aZone.Luminaires);
            end
            
            function pSet(aLuminaire, dimState, dimLevel)
                thisDimState = dimState & ~aLuminaire.State;
                aLuminaire.State(thisDimState) = dimLevel;
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

