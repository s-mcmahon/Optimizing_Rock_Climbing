% *---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
% Hill Climbing Algorithm Function
% *---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
% Description: For the height of the rock wall the program will generate
% neighbors, determine potential route costs, and then select the optimal
% path based on the minimum energy cost.

function [optimalRoute, costs, movementCosts] = hillClimbingAlgorithm(startingRoute, routeTerrain)
    currentRoute = startingRoute;
    costs = [];
    movementCosts= [];
    optimalRoute = currentRoute;
    while currentRoute(2) < 200 %hard coded dimensions of the rock face (height) 
        neighbors = generateNeighbors(currentRoute, routeTerrain);% generate neighboring holds 
        neighborsMovementCosts = ones(length(neighbors), 1)*.100; % generate array to contain costs of each movmement
        neighborsRouteCosts = ones(length(neighbors), 1)*.100; % generate array to contain costs of each route
        for index = 1:length(neighbors)
            possibleRoute = neighbors(index, :);
            [rCost, movementCost] = routeCost(possibleRoute, index, routeTerrain);
            neighborsRouteCosts(index) = rCost;
            neighborsMovementCosts(index) = movementCost;
        end
        [minimumCost, i] = min(neighborsMovementCosts); % find minimum
        currentRoute = neighbors(i, :); 
        currentCost = neighborsRouteCosts(i);
        costs = [costs; currentCost]; % Store movement
        movementCosts = [movementCosts; minimumCost];
        optimalRoute = [optimalRoute; currentRoute]; % Update optimal route
 
    end
end

% *---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
% Route Cost Function
% *---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
% Description: Determines the energy cost of the movement using the mock
% climbers assign terrain. Note that a factor was applied to the cost in order 
% to distquish more ideal movements (upward movement most notably straight
% up). 

function [rCost, movementCost] = routeCost(currentRoute, index, routeTerrain)
   % Define the movement costs for each direction
    %  2 - up, sqrt(2) - up+right and up+left,1 - left and right
    costFactors = [1/2, 1/sqrt(2), 1/sqrt(2), 1, 1];
    currentEnergyCost = routeTerrain(currentRoute(1), currentRoute(2));
    movementCost = currentEnergyCost * costFactors(index);
    rCost = currentEnergyCost;
end 

% *---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
% Generate Neighbors Function
% *---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
% Description: Simply takes in the position of the mock climber and finds
% its neighboring holds. For the sake of this project no down climbing was
% allowed so ony neighboring position to the left, right, up, up and right,
% and up and left were found and return. 

function neighbors = generateNeighbors(currentRoute, routeTerrain)
    [rows, cols] = size(routeTerrain);
    row = currentRoute(1);
    col = currentRoute(2);
    neighbors = ones(5, 2);
    % Move up
    if col < cols
        neighbors(1, :) = [row, col+1];
    end
    % Move up + right
    if col < cols && row < rows
        neighbors(2, :) = [row+1, col+1];
    end
    % Move up + left
    if col < cols && row > 1
        neighbors(3, :) = [row-1, col+1];
    end
    % Move right
    if row < rows
        neighbors(4, :) = [row+1, col];
    end
    % Move left
    if row > 1
        neighbors(5, :) = [row-1, col];
    end
end

