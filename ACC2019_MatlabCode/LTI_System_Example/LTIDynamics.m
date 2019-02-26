%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION: Defines the dynamics equations for the LTI system
% INPUT:
    % x_k : state at time k, a real number
    % u_k : control action at time k, a real number
    % w_k : disturbance realization at time k, a real number
% OUTPUT: state at time k+1, a real number
% AUTHOR: Margaret Chapman
% DATE: September 3, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function x_kPLUS1 = LTIDynamics( x_k, u_k, w_k )

x_kPLUS1 = x_k + u_k + w_k;



