%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION: Generates one sample trajectory, pond dynamics
% INPUT:
    % u(1) = u0, u(2) = u1, ..., u(N) = uN-1 : fixed sequence of control inputs
    % x0 : initial state, real number
    % xs : discretized states, a vector
    % ws(i) : ith possible value of wk
    % N: time horizon is {0, 1, ..., N} 
    % dt : duration of [k,k+1) interval
    % area_pond : approx. surface area of pond
    % tick_P = [ 0, P(1), P(1)+P(2), ..., P(1)+...+P(nw-1), 1 ], nw = length(ws)
        % P(i) : probability that wk = ws(i)
% OUTPUT:
    % myTraj(1) = x0, myTraj(2) = x1, ..., myTraj(N+1) = xN
% If xk+1 > max(xs), we set xk+1 = max(xs). This ensures that scenario tree is equivalent to that used in dynamic programming.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function myTraj = sample_traj( u, x0, xs, ws, N, dt, area_pond, tick_P )               

myTraj = [ x0; zeros( N, 1 ) ];                                 % initialize trajectory

for k = 0 : N-1                                                 % for each time point

    wk = sample_wk( ws, tick_P );                               % sample the disturbance at time k according to P
    
    xk = myTraj(k+1);                                           % state at time k
    
    uk = u(k+1);                                                % control input at time k

    xkPLUS1 = pond_dynamics_dt( xk, uk, wk, dt, area_pond );    % get next state realization
    
    if xkPLUS1 > max(xs), xkPLUS1 = max(xs); end                % snap to grid on boundary
    
    myTraj(k+2) = xkPLUS1;                                      % state at time k+1
    
end