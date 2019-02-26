%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION: Performs the CVaR Bellman backwards recursion
% INPUT: 
    % J_k+1 : optimal cost-to-go at time k+1, array
    % X : row of states repeated [ xs; xs; ... ], array
    % L : column of confidence levels repeated [ ls ls ... ], array
    % ws(i): ith possible value of wk
    % P(i): probability that wk = ws(i)
    % m : soft-max parameter for stage_cost.m
% OUTPUT: 
    % J_k : optimal cost-to-go starting at time k, array
    % mu_k : optimal controller at time k, array
% AUTHOR: Margaret Chapman
% DATE: August 24, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ J_k, mu_k ] = CVaR_Bellman_Backup( J_kPLUS1, X, L, ws, P, m )

xs = X(1,:); ls = L(:,1); % discretized states, discretized confidence levels

[ nl, nx ] = size( X ); % nl = # discrete confidence levels, nx = # discrete states

J_k = J_kPLUS1; mu_k = J_kPLUS1;         % initialization

for i = 1 : nx          % <--x's change along columns of J_k, X, L-->
    
    for j = 1 : nl
        
        x = X(j,i);     % state at (j,i)-grid point
        
        y = L(j,i);     % confidence level at (j,i)-grid point
        
        us = getPossControls( x, xs ); % returns possible control actions at state x
        
        maxExp_u1 = maxExp( J_kPLUS1, x, us(1), y, xs, ls, ws, P ); 
        
        maxExp_u2 = maxExp( J_kPLUS1, x, us(2), y, xs, ls, ws, P );
        
        if maxExp_u1 >= maxExp_u2, uStar = us(2); else uStar = us(1); end
        
        J_k(j,i) =  min( stage_cost(x,m) + maxExp_u1, stage_cost(x,m) + maxExp_u2 ); % Jk(x,y)
        
        mu_k(j,i) = uStar;
        
    end
    
end