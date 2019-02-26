%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION: Computes CVaR of a random variable Z, where Pr{Z = z(i)} = p(i)
% INPUT: 
    % z(i): ith realization of Z
    % p(i): probabilility of Z = z(i)
    % alpha: confidence level
% OUTPUT: CVaR of Z at confidence level alpha
% AUTHOR: Donggun Lee and Margaret Chapman
% DATE: August 30, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function CVaR = getCVaR( z, p, alpha )

cvx_begin quiet

    variable c(1,1)
    
        cost = c;
        
        for i = 1 : length(z), cost = cost + 1/alpha * max( z(i) - c, 0 ) * p(i); end
            
        minimize( cost ) 

cvx_end

if isinf(cvx_optval) || isnan(cvx_optval), error('getCVaR.m LP solution not found. m too high.'); end

CVaR = cvx_optval;
