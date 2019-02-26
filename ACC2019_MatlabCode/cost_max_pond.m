%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION: Returns max{ g(xk) : k = 0, 1, ..., N }, g(x) = signed distance w.r.t. constraint set, K = (0,5)
% INPUT: State trajectory (x0, x1, ..., xN), xk is a real number
% OUTPUT: Maximum signed distance over state trajectory
% AUTHOR: Margaret Chapman
% DATE: September 6, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function cost = cost_max_pond( x )

cost = max( signed_distance_pond(x) );
