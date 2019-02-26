%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION: Computes J0(x,y) := min_pi CVaR_y[ COST(x0, ..., xN) | x0 = x, pi ] via Monte Carlo for pond example
    % COST(x0, ..., xN) = exp(m*g(x0)) + ... + exp(m*g(xN)) "cost_sum" or
    %                   = max{ g(xk) : k = 0,...,N } "cost_max";
    % g: signed distance function w.r.t constraint set
    % Assumes that the best policy is to release water
% INPUT:
    % type_sum = 1 specifies cost_sum.m; type_sum = 0 specifies cost_max.m
    % xs: discretized states, a vector
    % ls: discretized confidence levels, a vector
    % ws: ws(i) is the ith possible value of wk
    % P: Pr{w_k = ws(i)} = P(i)
    % m: greater than or equal to 1, soft-max parameter for cost_sum.m
    % N: time horizon is {0, 1, ..., N}
    % dt : duration of [k,k+1) interval
    % area_pond : approx. surface area of pond
% OUTPUT: J0(l_index, x_index) = optimal value at initial state xs(x_index) & confidence level ls(l_index) 
% AUTHOR: Margaret Chapman
% DATE: September 6, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function J0 = MonteCarlo_CVaR_pond( type_sum, xs, ls, ws, P, m, N, dt, area_pond )

nw = length(ws); tick_P = zeros( nw + 1, 1 );                       % nw : number of possible values of wk

for i = 1 : nw, tick_P(i+1) = tick_P(i) + P(i); end                 % tick_P = [ 0, P(1), P(1)+P(2), ..., P(1)+...+P(nw-1), 1 ]

nl = length(ls); nx = length(xs); J0 = zeros( nl, nx );

nt = 100000;                                                        % number of trials per grid point

for l_index = 1 : nl                                                % for each grid point
for x_index = 1 : nx
    
    y = ls(l_index);                                                % confidence level at grid point
    
    x = xs( x_index );                                              % state at grid point
    
    uStar = ones(N,1);                                              % uStar(1) = u*(0), ..., uStar(N) = u*(N-1)
    
    sample_costs = zeros(nt, 1);
    
    for q = 1 : nt                                                  % for each trial
    
        myTraj = sample_traj( uStar, x, xs, ws, N, dt, area_pond, tick_P ); % get trajectory sample
                                                                            % myTraj(1) = x0, myTraj(2) = x1, ..., myTraj(N+1) = xN
                                                                            
        % get cost of trajectory sample
        if type_sum, sample_costs(q) = cost_sum_pond( myTraj, m ); small_sd = 10^(-7); 
        % max{ sample_cost } = (N+1)*beta*exp(m*1.5) = 1.6*10^5, since m = 10, beta = 10^(-3), N = 48
            
        else, sample_costs(q) = cost_max_pond( myTraj ); small_sd = 10^(-12); 
        % max{ sample_cost } = max( g(x) ) = 1.5, since x <= 6.5

        end
        
        % + ~N(0, small standard deviation), add small Gaussian noise so we can use CVaR estimator for continuous random variables
        sample_costs(q) = sample_costs(q) + small_sd*randn(1);
        
    end
    
    var = quantile( sample_costs, 1-y ); % VaR_y[Z] is the (1-y)-quantile of the distribution of Z
    
    J0(l_index, x_index) = estimateCVaR( sample_costs, y, var );
    
    disp(['grid point ', num2str(l_index), ' ', num2str(x_index), ' done']);                           
end
end