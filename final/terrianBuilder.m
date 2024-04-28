%% Terrain Builder Function 
% Description: 
function terrains = terrianBuilder(height, width, mockClimbers, climbingLevels) 
    [x, y] = meshgrid((-(width-.5)/2):1:((width-.5)/2), 0:1:(height-1)); 
    dimensions = x;
    overallClimbingInfo = climbingLevels(5);
    for i = 1:length(mockClimbers)
        currentClimber = mockClimbers(i);
        if strcmp(currentClimber.climbingLevel, 'beginner')
            project = currentClimber.project;
            climbingLevelInfo = climbingLevels(1);
            terrain1 = Terrain(dimensions, project, climbingLevelInfo, overallClimbingInfo);
            plotTerrain(x, y, terrain1, currentClimber)
        elseif strcmp(currentClimber.climbingLevel, 'intermediate')
            climbingLevelInfo = climbingLevels(2);
            project = currentClimber.project;
            terrain2 = Terrain(dimensions, project, climbingLevelInfo, overallClimbingInfo);
            plotTerrain(x, y, terrain2, currentClimber)
        elseif strcmp(currentClimber.climbingLevel, 'pro')
            climbingLevelInfo = climbingLevels(3);
            project = currentClimber.project;
            terrain3 = Terrain(dimensions, project, climbingLevelInfo, overallClimbingInfo);
            plotTerrain(x, y, terrain3, currentClimber)
        elseif strcmp(currentClimber.climbingLevel, 'advanced')
            climbingLevelInfo = climbingLevels(4);
            project = currentClimber.project;
            terrain4 = Terrain(dimensions, project, climbingLevelInfo, overallClimbingInfo);
            plotTerrain(x, y, terrain4, currentClimber)
        end
    end
    terrains = [terrain1 terrain2 terrain3 terrain4];
end 

function terrain = Terrain(dimensions, project, climbingLevelInfo, overallClimbingInfo)
    terrain = zeros(size(dimensions));
    projectIndex = find(strcmp(overallClimbingInfo.ratings, project));
    if ~isempty(projectIndex)
        projectEnergyCost = overallClimbingInfo.ratingsEnergyCost(projectIndex);
    else
        disp("Project not found: " + project);
        return; 
    end

  
    numElements = numel(terrain); % Amount of Elements in Terrain Array 
    deviationRange = 0.2 * projectEnergyCost; % Range of Energy Cost --> 2 Standard Deviations from Project Climb 
    for i = 1:numElements
        deviation = randn * deviationRange; % Random Deviation in Range
        terrain(i) = max(0, min(projectEnergyCost + deviation, max(climbingLevelInfo.ratingsEnergyCost))); % Check Validity of Assignment 
    end
    terrain = round(terrain); % Ensure Whole Number in order to match values in ratingEnergyCost Array 
    disp("Average: " + mean(terrain(:)) + ", Average (rounded): " + round(mean(terrain(:))) + ", Expected: " + projectEnergyCost) % displays final data of Mountain Range Assign Energy Cost
end


function plotTerrain(height, width, terrain, currentClimber)
    figure;
    surf(height, width, terrain);
    colormap("parula");
    xlabel('X (ft)');
    ylabel('Y (ft)');
    zlabel('Cost (Kcal)');
    title(['Route - Mountain Terrain for Poject: ', currentClimber.project]);
    colorbar;
end