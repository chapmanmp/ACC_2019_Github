%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION: Computes J0(x,y) := min_pi CVaR_y[ COST(x0, ..., xN) | x0 = x, pi ] via enumeration
    % COST(x0, ..., xN) = exp(m*g(x0)) + ... + exp(m*g(xN)) "cost_sum" or
    %                   = max{ g(xk) : k = 0,...,N } "cost_max";
    % g: signed distance function w.r.t constraint set
    % LTI dynamics: xk+1 = xk + uk + wk, wk \in {-1, 0, 1} equally probable
% AUTHORS: Margaret Chapman, Donggun Lee, Jonathan Lacotte
% DATE: August 30, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all; clearvars; clc;

Setup_LTI_Example;              % provides grid, constraint set, soft-max parameter, probability distribution, horizon, etc.

type_sum = 0;                   % choose 1 if cost_sum, choose 0 if cost_max

J0_Brute_Force = Brute_Force_CVaR( type_sum, xs, ls, ws, P, m ); 

figure; FigureSettings; mesh( X, L, J0_Brute_Force );

if type_sum, title(['Brute force (soft max, m = ', num2str(m), ')']); else, title('Brute force (max)'); end

xlabel('State, x'); ylabel('Confidence level, y'); zlabel(['J_0', '(x,y)']);









