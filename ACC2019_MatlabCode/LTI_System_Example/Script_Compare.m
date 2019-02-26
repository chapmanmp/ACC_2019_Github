%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION: Script to compare results
% DYNAMICS: xk+1 = xk + uk + wk, wk \in {-1, 0, 1} equally probable
% AUTHORS: Margaret Chapman, Donggun Lee, Jonathan Lacotte
% DATE: August 31, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Compare [brute force, soft-max] versus [dynamic programming, soft-max] to determine grid spacing (xs, ls)
    % first fix soft-max parameter to 1, later evaluate on other values
    % J0(x,y) := min_pi CVaR_y[ exp(m*g(x0)) + ... + exp(m*g(xN)) | x0 = x, pi ]

close all; clearvars; clc;

% load('Results_LTISystem\brute_force_cost_sum_mis1_LTI.mat'); % m = 1
load('Results_LTISystem\brute_force_cost_sum_mis10_LTI.mat'); % m = 10
% J0_Brute_Force(l_index, x_index): J0 evaluated at x = xs(x_index), y = ls(l_index) computed via Main_BruteForce.m, type_sum = 1

% load('Results_LTISystem\dynamic_programming_mis1_LTI.mat'); % m = 1
load('Results_LTISystem\dynamic_programming_mis10_LTI.mat'); % m = 10
% Js{1}(l_index, x_index): J0 evaluated at x = xs(x_index), y = ls(l_index) computed via Main_DynProgram.m

array_diff = abs( J0_Brute_Force - Js{1} ); % element-wise absolute value

max_diff = max( array_diff(:) );            % largest difference for m = 1 is 0.0364
                                            % largest difference for m = 10 is 3.5380

%% Compare [brute force, soft-max] versus [brute force, max] to determine soft-max parameter (m)
% m = 1, U_y^r was a very small subset of S_y^r
% m = 100, numerically unstable, getCVaR.m returned Inf
% m = 10, U_y^r is a better underapproximation to S_y^r

close all; clearvars; clc;

load('Results_LTISystem\brute_force_cost_sum_mis10_LTI.mat'); J0_cost_sum = J0_Brute_Force;
% J0_Brute_Force(l_index, x_index) = min_pi CVaR_y[ exp(m*g(x0)) + ... + exp(m*g(xN)) | x0 = x, pi ], m = 10
    % at y = ls(l_index), x = xs(x_index)
    % computed via Main_BruteForce.m, type_sum = 1
    
load('Results_LTISystem\brute_force_cost_max_LTI.mat'); J0_cost_max = J0_Brute_Force;
% J0_Brute_Force(l_index, x_index) = min_pi CVaR_y[ max{g(x0), ..., g(xN)} | x0 = x, pi ]
    % at y = ls(l_index), x = xs(x_index)
    % computed via Main_BruteForce.m, type_sum = 0

rs = 1/2: 1/4: 1; % risk levels to be plotted

[ U, S ] = getRiskySets( ls, xs, rs, m, J0_cost_sum, J0_cost_max ); % xticklabels are hardcoded, should be function of xs

%% To illustrate our method, compare [ground truth: brute force, max] versus [our method: dynamic programming, soft-max]

close all; clearvars; clc;

load('Results_LTISystem\brute_force_cost_max_LTI.mat'); J0_cost_max = J0_Brute_Force;
% J0_Brute_Force(l_index, x_index) = min_pi CVaR_y[ max{g(x0), ..., g(xN)} | x0 = x, pi ]
    % at y = ls(l_index), x = xs(x_index)
    % computed via Main_BruteForce.m, type_sum = 0
    
load('Results_LTISystem\dynamic_programming_mis10_LTI.mat'); J0_cost_sum = Js{1};
% Js{1}(l_index, x_index) = min_pi CVaR_y[ exp(m*g(x0)) + ... + exp(m*g(xN)) | x0 = x, pi ], m = 10
    % at y = ls(l_index), x = xs(x_index)
    % computed via Main_DynProgram.m

rs = 1/4: 1/4: 1; % risk levels to be plotted, chosen based on range of J0_cost_max

[ U, S ] = getRiskySets( ls, xs, rs, m, J0_cost_sum, J0_cost_max ); % xticklabels are hardcoded, should be function of xs


