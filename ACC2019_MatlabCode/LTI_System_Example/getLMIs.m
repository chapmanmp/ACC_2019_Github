%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION: Computes the parameters for linear matrix inequalities 
% INPUT: 
    % x : state at time k, real number
    % u : control at time k, real number
    % ws(i) : ith realization of disturbance, real number
    % xs : x values, row vector
    % ls : confidence levels, row vector
    % J_k+1 : optimal cost-to-go at time k+1, array
% OUTPUT: 
    % As{i} & bs{i} are column vectors that encode the linear interpolation of y*J_k+1( x_k+1, y ) vs. y, at the ith realization of x_k+1
    % ith realization of x_k+1 = x + u + ws(i)
% NOTE:
    % max_t,y { t | As{1}(i)*y + bs{1}(i) >= t } is equivalent to max_y { g(y) := min_i As{1}(i)*y + bs{1}(i) }                                          
    % g(y) = linear interpolation of y*J_k+1(x,y) vs. y, at fixed x; concave & piecewise linear in y
    % uses Chow, et al. NIPS 2015 to manage continuous confidence level
    % uses linear interpolation to manage continuous state space
% AUTHOR: Margaret Chapman
% DATE: August 27, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ As, bs ] = getLMIs( x, u, ws, xs, ls, J_kPLUS1 )

nd = length(ws); % # disturbance realizations

nl = length(ls); % # confidence levels

As = cell(nd, 1); bs = cell(nd, 1); 

for i = 1 : nd % for each disturbance realization

    x_kPLUS1 = LTIDynamics( x, u, ws(i) ); % get next state realization
    
    Ai = zeros(nl-1,1); bi = zeros(nl-1,1);
        
    for j = nl-1: -1: 1 % for each confidence level line segment, [l_j+1, l_j], e.g., ls = [l_1 = 0.95, l_2 = 1/2, l_3 = 0.05] 
                        % [l_3, l_2] = [0.05, 1/2] 
                        % [l_2, l_1] = [1/2, 0.95]
                
        J_jPLUS1 = interp1( xs, J_kPLUS1(j+1,:), x_kPLUS1, 'linear' ); 
        % approximates J_k+1(x_k+1, l_j+1) using J_k+1(xL, l_j+1) and J_k+1(xU, l_j+1), xL <= x_k+1 <= xU
        % Vq = interp1(X,V,Xq,'linear') interpolates to find Vq, the values of the underlying function V=F(X) at the query points Xq. 

        J_j = interp1( xs, J_kPLUS1(j,:), x_kPLUS1, 'linear' ); 
        
        Ai(j) = ( ls(j)*J_j - ls(j+1)*J_jPLUS1 )/( ls(j)-ls(j+1) ); 
        % approx. slope of jth line segment of linear_interp( y*J_k+1( x_k+1, y ) vs. y ) 
        
        bi(j) = ls(j+1) * (J_jPLUS1 - Ai(j));                       
        % approx. y-int of jth line segment of linear_interp( y*J_k+1( x_k+1, y ) vs. y )
    end
    
    As{i} = Ai; bs{i} = bi;
    
end