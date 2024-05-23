% Description: A Class that can contain all relevant information
% regarding the mock climbers used in this study's simulations. 

% *---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
% Mock Climber Class 
% *---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*

classdef MockClimber
    properties
        name            
        climbingLevel      
        project 
    end
    
    methods
        function obj = MockClimber(name, skillLevel, project)
            obj.name = name;
            obj.climbingLevel = skillLevel;
            obj.project = project; 
        end
    end
end

