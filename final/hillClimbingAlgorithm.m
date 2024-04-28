%% Hill Climbing Algorithm Functions
% Description: 

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


