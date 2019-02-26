%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION: Defines discrete-time dynamics of pond
% INPUT:
    % xk : water elevation at time k [ft]
    % uk : valve setting at time k [no units]
    % wk : average surface runoff rate on [k, k+1) [ft^3/s]
    % dt : duration of [k, k+1) [sec]
    % A : approx. surface area, pond 1 (south) [ft^2]
% OUTPUT:
    % xkPLUS1 : water elevation at time k+1 [ft]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function xkPLUS1 = pond_dynamics_dt( xk, uk, wk, dt, A )

Rpond = 1/3;                                    % outlet radius [ft]

f = ( wk - q_outlet( xk, uk, Rpond ) )/A;  % time-derivative of x [ft/s]
   %dx = ( d{1} - q_outlet(x{1},u{1}) ) ./(A1);

xkPLUS1 = xk + f*dt;


        
        