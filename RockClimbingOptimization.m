%% Optimizing Energy Efficiency in Outdoor Rock Climbing Routes for Climbers

%% Introduction
% * Authors: Sarah McMahon and Shua Jeon 
% * Department: Electrical and Systems Engineering Department at Washington
% Universtiy in St. Louis 
% * Course: ESE 415 - Optimization 
% * Date: Created 4/18/2024, Last Edited 4/28/2024
% * Purpose: This project applies the Hill Climbing Optimization Algorithm
% to outdoor Rock Climbing, aiming to enhance energy efficiency while maintaining
% a specific difficulty level. 

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
[x, y, routeTerrians] = terrianBuilder(height, width, mockClimbers, climbingLevels);
routeTerrian1 = (routeTerrians(:, 1:20))';
routeTerrian2 = (routeTerrians(:, 21:40))';
routeTerrian3 = (routeTerrians(:,41:60)');
routeTerrian4 = (routeTerrians(:, 61:80)');
% uses the terrain builder function in order to generate the necessary
% terrains for the mock climbers

%% Hill Climbing Algorithm 
% Description: This segment of code contains the definition of the climbers
% starting position on the wall and the implementation of the hill climbing
% algorithm defined in the corresponding file. 

% *---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
% Implemenation 
% *---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
startingRoute = [10, 1];   % randomly choosen
[optimalRoute1, costs1, movementCosts1] = hillClimbingAlgorithm(startingRoute, routeTerrian1);
[optimalRoute2, costs2, movementCosts2] = hillClimbingAlgorithm(startingRoute, routeTerrian2);
[optimalRoute3, costs3, movementCosts3] = hillClimbingAlgorithm(startingRoute, routeTerrian3);
[optimalRoute4, costs4, movementCosts4] = hillClimbingAlgorithm(startingRoute, routeTerrian4);
% optimalRoute- is a matrix that contains the optimal positional changes of the
% climber throughtout the climb, costs- is a array that contains the cost
% of each movement made by the climber throughout the climb (without
% accounting for movementCost), and movementCosts- is an array that
% contains the cost of each move while accounting for movment cost.
%% Results 
% Description: This section is solely used to display relevant graphs and
% data points. 

% *---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
% Terrian + Path Graph 
% *---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
% Terrian + Path Graph 
% Plot the terrain
plotClimbingRoute(x, y, optimalRoute1,  routeTerrian1, climber1.project);
plotClimbingRoute(x, y, optimalRoute2,  routeTerrian2, climber2.project);
plotClimbingRoute(x, y, optimalRoute3,  routeTerrian3, climber3.project);
plotClimbingRoute(x, y, optimalRoute4,  routeTerrian4, climber4.project);

% *---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
% Efficiency 
% *---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
% Cost per Movement
plotClimbingCost(costs1, climber1.project);
plotClimbingCost(costs2, climber2.project);
plotClimbingCost(costs3, climber3.project);
plotClimbingCost(costs4, climber4.project);

% *---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
% Display Variables 
% *---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
disp(['Climber 1 Total Ideal Cost: ', num2str(sum(costs1))]);
disp(['Climber 2 Total Ideal Cost: ', num2str(sum(costs2))]);
disp(['Climber 3 Total Ideal Cost: ', num2str(sum(costs3))]);
disp(['Climber 4 Total Ideal Cost: ', num2str(sum(costs4))]);

disp(['Climber 1 Total Cost: ', num2str(sum(movementCosts1))]);
disp(['Climber 2 Total Cost: ', num2str(sum(movementCosts2))]);
disp(['Climber 3 Total Cost: ', num2str(sum(movementCosts3))]);
disp(['Climber 4 Total Cost: ', num2str(sum(movementCosts4))]);

%%  Relevant Functions 
% Description: Any functions that did not fall under existing file topics. 
function plotClimbingRoute(x, y, optimalRoute, routeTerrain, project)
    yR = optimalRoute(:, 2);
    xR = optimalRoute(:, 1) - 10;
    figure;
    subplot(2,1,1)
    surf(x, y, routeTerrain', 'EdgeColor', 'none');
    view(2, -90);
    colormap("parula"); 
    colorbar; 
    clim([1 37]);
    xlabel('X'); 
    ylabel('Y'); 
    zlabel('Cost');
    title(['Route - Mountain Terrain for Poject: ', project]); 
    subplot(2,1,2)
    surf(x, y, routeTerrain', 'EdgeColor', 'none');
    view(2, -90);
    colormap("parula"); 
    colorbar;
    clim([1 37]);
    xlabel('X'); 
    ylabel('Y'); 
    zlabel('Cost'); 
    title(['Route - Mountain Terrain for Project: ', project]); 
    hold on;
    plot(xR, yR, '-k', 'LineWidth', 2)
    hold off; 
end 

function plotClimbingCost(costs, project)
    figure;
    plot(costs); 
    hold on;
    x1 = 1:length(costs); 
    p = polyfit(x1, costs', 1);
    y_fit = polyval(p, x1);
    plot(x1, y_fit, 'r--', 'LineWidth', 2);
    hold off;
    xlabel('Movement');
    ylabel('Cost');
    title(['Cost per Movement of Optimal Route with Regression Line for Project ', project]);
    legend('Movement Cost', 'Regression Line');
end



