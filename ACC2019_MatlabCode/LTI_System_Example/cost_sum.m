%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION:  Returns sum of exponentials, exp(m*g(x0)) + exp(m*g(x1)) + ... + exp(m*g(xN)); 
%               g is signed distance w.r.t. constraint set, K = (2,4)
% INPUT: 
    % State trajectory (x0, x1, ..., xN), xk is a real number
    % m: greater than or equal to 1, soft-max parameter
% OUTPUT: Sum of exponentials (real number)
% AUTHOR: Margaret Chapman
% DATE: August 31, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function cost = cost_sum( x, m )

cost = sum( stage_cost( x, m ) );