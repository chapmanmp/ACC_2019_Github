%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION: Estimate CVaR from empirical data
% INPUT:
    % Z(i): ith sample of random variable Z
    % y: confidence level
    % var: approx. VaR_y[Z] using the empirical distribution of Z
% OUTPUT:
    % approx. CVaR_y[Z] using the empirical distribution of Z
% NOTE:
    % Uses esimator provided by Shapiro's text
    % Sec. 6.5.1 Average Value-at-Risk, p. 300, Lectures on Stochastic Programming Modeling and Theory, 2009, SIAM
    % See also Jonathan Lacotte's notes (notes_cvar_estimator.pdf)
% AUTHOR: Margaret Chapman
% DATE: September 6, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function cvar = estimateCVaR( Z, y, var )

ind = (Z >= var);       % ind(i) = 1 if Z(i) >= var
                        % ind(i) = 0 if Z(i) < var
                        
N = length(Z);          % number of samples of Z
                        
cvar = sum( Z.*ind ) / (y*N); 
    



