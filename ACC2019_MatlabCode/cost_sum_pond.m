%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION:  Returns sum of exponentials, exp(m*g(x0)) + exp(m*g(x1)) + ... + exp(m*g(xN)); 
%               g is signed distance w.r.t. constraint set, K = (0,5)
% INPUT: 
    % State trajectory (x0, x1, ..., xN), xk is a real number
    % m: greater than or equal to 1, soft-max parameter
% OUTPUT: Sum of exponentials (real number)
% AUTHOR: Margaret Chapman
% DATE: September 9, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function cost = cost_sum_pond( x, m )

cost = sum( stage_cost_pond( x, m ) );