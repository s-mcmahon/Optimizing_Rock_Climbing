classdef MockClimber
    properties
        name            
        climbingLevel      
        project 
    end
    
    methods
        % Constructor method
        function obj = MockClimber(name, skillLevel, project)
            % Constructor initializes the properties of the object
            obj.name = name;
            obj.climbingLevel = skillLevel;
            obj.project = project; 
        end
    end
end

