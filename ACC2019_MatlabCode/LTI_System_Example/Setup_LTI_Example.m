%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION: Set-up script for linear time-invariant dynamics example
% DYNAMICS: x_k+1 = x_k + u_k + w_k, w_k \in {-1, 0, 1} equally probable
% AUTHOR: Margaret Chapman
% DATE: August 31, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dx = 1/10;                                      % State discretization

K_lb = 2; K_ub = 4;                             % Constraint set, K = (2, 4)

xs = K_lb - 1 : dx : K_ub + 1;                  % Discretized states

ls = [ 0.999, 0.95:-0.15:0.05, 0.001 ];         % Discretized confidence levels

[ X, L ] = meshgrid( xs, ls );

N = 2;                                          % Time horizon: {0, 1, ..., N}

ws = [ -1; 0; 1 ];                              % ws(i): ith possible value of wk

P = [ 1/3; 1/3; 1/3 ];                          % P(i): probability that wk = ws(i)

m = 10;                                         % soft-max parameter
