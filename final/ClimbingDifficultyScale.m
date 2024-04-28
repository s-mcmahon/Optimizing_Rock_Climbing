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
