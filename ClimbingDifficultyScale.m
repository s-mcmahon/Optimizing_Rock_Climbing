% Description: A Class that can contain all relevant information
% regarding the the terrain and rock climbing in general used in this 
% study's simulations. 

% *---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
% Climbing Difficulty Scale Class 
% *---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*


classdef ClimbingDifficultyScale
    properties
        level
        ratings
        ratingsEnergyCost 
    end
    
    methods
        function obj = ClimbingDifficultyScale(climbingLevel, ratings, ratingsEnergyCost)
            obj.level = climbingLevel;
            obj.ratings = ratings;
            obj.ratingsEnergyCost = ratingsEnergyCost;
        end
    end
end
