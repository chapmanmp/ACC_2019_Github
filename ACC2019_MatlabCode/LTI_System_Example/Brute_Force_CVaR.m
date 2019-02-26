%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION: Computes J0(x,y) := min_pi CVaR_y[ COST(x0, ..., xN) | pi, x0 = x ] via enumeration
    % System: x_k+1 = x_k + u_k + w_k, k = 0, ..., N
    % COST(x0, ..., xN) = exp(m*g(x0)) + ... + exp(m*g(xN)) "cost_sum", or
    %                   = max{ g(xk) : k = 0, ..., N }  "cost_max"
    % N = 2
    % Distribution of w_k is time-invariant
% INPUT:
    % type_sum = 1 specifies cost_sum.m; type_sum = 0 specifies cost_max.m
    % xs: discretized states, a vector
    % ls: discretized confidence levels, a vector
    % ws: ws(i) is the ith possible value of wk
    % P: Pr{w_k = ws(i)} = P(i)
    % m: greater than or equal to 1, soft-max parameter for cost_sum.m
% OUTPUT: J0(l_index, x_index) = optimal value at initial state xs(x_index) & confidence level ls(l_index) 
% AUTHOR: Margaret Chapman and Donggun Lee
% DATE: August 31, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function J0 = Brute_Force_CVaR( type_sum, xs, ls, ws, P, m )

na = length( getPossControls(xs(1), xs) );      % max # possible control actions at each time point

for l_index = 1 : length(ls)                    % for each (x0, confidence level)
for x_index = 1 : length(xs), x0 = xs( x_index );
    
    for ii = 1 : na                             % for each (u0, u1)
    for jj = 1 : na 
        
        for kk = 1 : length(ws)                 % for each (w0, w1)
        for ll = 1 : length(ws) 
            
            u0s = getPossControls( x0, xs );    % ensures scenario tree is equivalent to that used in DP
            x1 = LTIDynamics( x0, u0s(ii), ws(kk) ); % x1
                
            u1s = getPossControls( x1, xs );    % ensures scenario tree is equivalent to that used in DP
            x2 = LTIDynamics( x1, u1s(jj), ws(ll) ); % x2 
            
            if type_sum, my_cost = cost_sum([x0, x1, x2],m); else, my_cost = cost_max([x0, x1, x2]); end
               
            cost_real{ii,jj}(kk,ll) = my_cost;  % cost realization
            prob{ii,jj}(kk,ll) = P(kk) * P(ll); % probability of cost realization
            
        end         
        end                                     
                                                % CVaR of cost at fixed (u0, u1)
        CVaR{l_index, x_index}(ii,jj) = getCVaR( cost_real{ii,jj}(:), prob{ii,jj}(:), ls(l_index) );
    
    end
    end 
                                                % min_u { CVaR(u) | confidence = ls(l_index), x0 = xs(x_index) }
    J0(l_index, x_index) = min( CVaR{l_index, x_index}(:) );
    
end
end