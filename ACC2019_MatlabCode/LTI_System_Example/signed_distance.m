%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION: Defines the signed distance function w.r.t. the constraint set, K = (2, 4)
% INPUT: State xk, or state trajectory (x0, x1, ..., xN)
% OUTPUT: Signed distance w.r.t. K = (2, 4)
% AUTHOR: Margaret Chapman
% DATE: September 1, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function gx = signed_distance( x )

gx = abs( x - 3 ) - 1;