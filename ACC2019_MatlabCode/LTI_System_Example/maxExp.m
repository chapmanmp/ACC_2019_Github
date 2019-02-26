%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION: Computes max over R \in risk envelope of E[ R*J_k+1( x_k+1, y*R ) | x_k, y, u_k ]
%              Uses Chow 2015 linear interpolation method on confidence level
%              Uses change of variable, Z := y*R 
% INPUT: 
    % J_k+1 : optimal cost-to-go at time k+1, array
    % x : state at time k, real number
    % u : control at time k, real number
    % y : confidence level at time k, real number
    % xs : x values, row vector
    % ls : confidence levels, row vector
    % ws(i): ith possible value of w_k
    % P(i): probability that w_k = ws(i)
% OUTPUT: approximation of maximum over R \in risk envelope of E[ R*J_k+1( x_k+1, y*R ) | x_k, y, u_k ]
% AUTHOR: Margaret Chapman
% DATE: August 24, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function bigexp = maxExp( J_kPLUS1, x, u, y, xs, ls, ws, P )

nd = length(ws); % # of possible values that disturbance can take on

[ As, bs ] = getLMIs( x, u, ws, xs, ls, J_kPLUS1 ); % As{i} & bs{i} are column vectors; 
% Each LMI encodes the linear interpolation of y*J_k+1( x_k+1, y ) versus y, at fixed x_k+1

cvx_begin quiet

    variables Z(nd,1) t(nd,1)
    
    maximize( P' * t / y )
    
    subject to
    
        % one LMI per disturbance realization (equivalently, per next state realization)
        for i = 1 : nd,  As{i}*Z(i) + bs{i} >= t(i); end 
          
        Z <= 1;
    
        Z >= 0;
    
        P' * Z == y;
    
cvx_end

if isinf(cvx_optval) || isnan(cvx_optval), error('maxExp.m LP solution not found.'); end

bigexp = cvx_optval;