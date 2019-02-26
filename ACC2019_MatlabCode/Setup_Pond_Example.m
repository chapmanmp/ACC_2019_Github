%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION: Set-up script for pond example, time-invariant finite probability distribution
    % wk : average surface runoff rate on [k,k+1), [ft^3/s]
% AUTHOR: Margaret Chapman
% DATE: September 5, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

K_lb = 0; K_ub = 5;                     % Constraint set bounds [ft], K = (0, 5ft)

dx = 1/10;                              % State discretization [ft]

xs = K_lb : dx : K_ub + 1.5;            % Discretized states [ft]

ls = [ 0.999, 0.95:-0.15:0.05, 0.001 ]; % Discretized confidence levels

[ X, L ] = meshgrid( xs, ls );

dt = 300;                               % Duration of [k, k+1) [sec], 5min = 300sec

T = 4*3600;                             % Design storm length [sec], 4h = 4h*3600sec/h

N = T/dt;                               % Time horizon: {0, 1, 2, ..., N} = {0, 5min, 10min, ..., 240min} = {0, 300sec, 600sec, ..., 14400sec}

surface_runoff_stats;                   % Provides possible values of surface runoff (ws) & moments
                                        % ws(i): ith possible value of wk (ft^3/s)

P = getProbDist(ws, Mymean, Myvariance, Myskewness); % P(i): probability that wk = ws(i)

m = 10;                                 % soft-max parameter

A = 28292;                              % approx. surface area, pond 1 (south) [ft^2]

