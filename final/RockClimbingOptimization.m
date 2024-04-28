%% Optimizing Energy Efficiency in Outdoor Rock Climbing Routes for Climbers

%% Introduction
% * Authors: Sarah McMahon and Shua Jeon 
% * Department: Electrical and Systems Engineering Department at Washington
% Universtiy in St. Louis 
% * Course: ESE 415 - Optimization 
% * Date: Created 4/18/2024, Last Edited 4/28/2024
% * READ ME: This project applies the Hill Climbing Optimization Algorithm
% to outdoor Rock Climbing, aiming to enhance energy efficiency while maintaining
% a specific difficulty level. (BEEF THIS UP)

%% Rock Climbing Integration (Variables) 
% Description: The varaibles defined in this section are used to describe a 
% variety of parameters that were used in order to integrate rock climbing into 
% the application of the hill climbing algorithm. For readability, these variables
% were divided into 3 cateogries: climbing difficulty scale, mock climber, route
% terrian. 

% *---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
% Climbing Difficulty Scale
% *---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
ratings  = [
    "5.2",   "5.3",   "5.4",   "5.5",   "5.6",   "5.7",   "5.8",   "5.9";
    "5.10a", "5.10b", "5.10c", "5.10d", "5.11a", "5.11b", "5.11c", "5.11d";
    "5.12a", "5.12b", "5.12c", "5.12d", "5.13a", "5.13b", "5.13c", "5.13d";
    "5.14a", "5.14b", "5.14c", "5.14d", "5.15a", "5.15b", "5.15c", NaN
            ];
% a 4x8 matrix containing the different rock climbing ratings (YST) each
% row is a different skill level
ratingsEnergyCost  = [
     1,  2,   3,   4,   5,   6,   7,   8;
    11, 12,  13,  14,  15,  16,  17,  18;
    21, 22,  23,  24,  25,  26,  27,  28;
    31, 32,  33,  34,  35,  36,  37, NaN
            ];
% a 4x8 matrix containing the different rock climbing ratings (YST) each
% row is a different skill level - arbitrarily assigned a Energy Cost
% (Kcal/minute) 
beginner = ClimbingDifficultyScale('beginner', ratings(1,:), ratingsEnergyCost(1,:));
intermediate = ClimbingDifficultyScale('intermediate', ratings(2,:), ratingsEnergyCost(2,:));
pro = ClimbingDifficultyScale('pro', ratings(3,:), ratingsEnergyCost(3,:));
advanced = ClimbingDifficultyScale('advanced', ratings(4,:), ratingsEnergyCost(4,:));
all = ClimbingDifficultyScale('all', ratings, ratingsEnergyCost);
climbingLevels = [beginner intermediate pro advanced all];
% uses the ClimbingDifficultyScale class in order to cleanly organize the
% different information needed for the four geenral accepted climbing skill
% levels for easy of use

% *---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
% Mock Climber
% *---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
climber1 = MockClimber('Miranda', 'beginner', '5.8');
climber2 = MockClimber('Mischa', 'intermediate', '5.10d');
climber3 = MockClimber('Julia', 'pro', '5.12b');
climber4 = MockClimber('George', 'advanced', '5.14c');
mockClimbers = [climber1 climber2 climber3 climber4]; 
% uses the MockClimber class in order to make 4 mock climbers
% with randomly assigned projects, in order to represent the 4 main skill
% levels of climbers.

% *---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
% Route Terrian 
% *---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
width = 20;
height = 200;
% height and width measure=ments are calculated in feet and were arbitarily
% choosen based on general route dimensions. 
routeTerrians = terrianBuilder(height, width, mockClimbers, climbingLevels);
routeTerrian1 = (routeTerrians(:, 1:20))';
routeTerrian2 = (routeTerrians(:, 21:40))';
routeTerrian3 = (routeTerrians(:,41:60)');
routeTerrian4 = (routeTerrians(:, 61:80)');
% uses the terrain builder function in order to generate the necessary
% terrains for the mock climbers

%% Hill Climbing Algorithm 
% Description: 

% *---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
% Initial Variables 
% *---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
currentRoute = [10, 1];  
goalPosition = [10, 200];

[neighbors, neighborsCosts] = hillClimbingAlgorithm(currentRoute, routeTerrian1);
%optimalRoute  = hillClimbing(initialPosition, goalPosition, routeTerrian1);

% *---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
% Hill Climbing Algorithm Function Implementation 
% *---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*


%% Results 
% Description: 

% *---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
% Terrian + Path Graph 
% *---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*


% *---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
% Graph of Hill Climbing 
% *---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*

% *---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
% Display Variables 
% *---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*

%% Function 


function [neighbors, neighborsCosts]= hillClimbingAlgorithm(currentRoute, routeTerrain)
    neighbors = generateNeighbors(currentRoute, routeTerrain); 
    neighborsCosts =  NaN(5, 1);
    disp(neighbors)
    disp(neighborsCosts)
    for index=1:length(neighbors)
        currentRoute = neighbors(index, :);
        disp(currentRoute)
        cost = routeCosts(currentRoute, index, routeTerrain);
        neighborsCosts(index) = cost;
    end
end

% Trajectory ------------    1,     1,  2, sqrt(2), sqrt(2)
function routeCost = routeCosts (currentRoute, index, routeTerrain)
   % Define the movement costs for each direction
    %  1 - up, 2 - up+rigt, 3 - up+left, 4 - left, 5 - right
    costFactors = [1/2, 1/sqrt(2), 1/sqrt(2), 1, 1];
    currentEnergyCost = routeTerrain(currentRoute(1), currentRoute(2));
    routeCost = currentEnergyCost * costFactors(index);
end 

% Movements limited to -- left, right, up, up+rigt, up+left
function neighbors = generateNeighbors(currentRoute, routeTerrain)
    [rows, cols] = size(routeTerrain);
    row = currentRoute(2);
    col = currentRoute(1);
    neighbors = NaN(5, 2);
    % Move up
    if row < rows
        neighbors(1, :) = [row+1, col];
    end
    % Move up + right
    if row < rows && col < cols
        neighbors(2, :) = [row+1, col+1];
    end
    % Move up + left
    if row < rows && col > 1
        neighbors(3, :) = [row+1, col-1];
    end
    % Move right
    if col < cols
        neighbors(4, :) = [row, col+1];
    end
    % Move left
    if col > 1
        neighbors(5, :) = [row, col-1];
    end
end


