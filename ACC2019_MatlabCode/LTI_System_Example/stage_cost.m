%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION: Defines the stage cost as an exponential of the signed distance w.r.t. constraint set, K = (2, 4)
% INPUT: 
    % x: array of states (vector or matrix)
    % m: greater than or equal to 1, soft-max parameter
% OUTPUT: Stage cost
% AUTHOR: Margaret Chapman
% DATE: August 24, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function c = stage_cost( x, m ) 

gx = signed_distance( x );  % signed distance with respect to the constraint set, K = (2, 4)

c = exp( m*gx );