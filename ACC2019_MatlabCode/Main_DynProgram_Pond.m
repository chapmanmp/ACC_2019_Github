%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION: Computes J0(x,y) := min_pi CVaR_y[ exp(m*g(x0)) + ... + exp(m*g(xN)) | x0 = x, pi ] via dynamic programming
    % CVaR Bellman recursion & interpolation over y proposed originally by Chow et al., NIPS, 2015
    % m: soft-max parameter, g: signed distance with respect to constraint set
    % pond example
% AUTHORS: Margaret Chapman
% DATE: September 5, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all; clearvars; clc;

Setup_Pond_Example;             % Provides grid, constraint set, soft-max parameter, probability distribution, horizon, etc.

Js = cell( N+1, 1 );            % Contains optimal value functions to be solved via dynamic programming
                                % Js{1} is J0, Js{2} is J1, ..., Js{N+1} is JN
                                
mus{N} = cell( N, 1 );          % Optimal policy, mus{N} is \mu_N-1, ..., mus{1} is \mu_0
                                % mu_k(x,y) provides optimal control action at time k, state x, confidence level y

Js{N+1} = stage_cost_pond( X, m );   % Initial value function, JN(x,y) = beta*exp(g(x)) for each y

% Do CVaR-Bellman Recursion
for k = N: -1: 1,  [ Js{k} , mus{k} ] = CVaR_Bellman_Backup_pond( Js{k+1}, X, L, ws, P, m, dt, A ); display(num2str(k-1)); end

% See Results
for k = N+1: -1: 1
    
    figure(k); FigureSettings; mesh( X, L, Js{k} ); title(['Dyn. Programming (soft-max, m = ', num2str(m),')']);
    
    xlabel('State, x'); ylabel('Confidence level, y'); zlabel(['Estimate of J_{', num2str(k-1), '}(x,y)']);
    
end
