%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION: Returns possible control actions given current state
% INPUT: 
    % x : current state (real number)
    % xs : discretized state space (array)
% OUTPUT:
    % us : possible control actions at current state (array)

% AUTHOR: Margaret Chapman
% DATE: August 28, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function us = getPossControls( x, xs )

na = 2;                     % two possible control actions at each time point

BIG_STEP = 2;               % largest | x_k+1 - x_k |; since max|u_k| = max|w_k| = 1 and x_k+1 = x_k + u_k + w_k

if x < min(xs) + BIG_STEP   
    
    us = ones(na,1);        % set u = +1 to stay in grid

elseif x > max(xs) - BIG_STEP   
    
    us = -ones(na,1);       % set u = -1 to stay in grid
    
else                        
    
    us = [-1; 1];           % otherwise, allow u = -1 or 1
    
end


