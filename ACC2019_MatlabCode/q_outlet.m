%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Author: Margaret P. Chapman
%Date: February 27, 2018

%PURPOSE: Computes outflow through pond outlet via orifice equation
%INPUT:
    %x = pond stage vector measured from pond base [ft]
    %u = valve setting vector, a proportion    
%OUTPUT: Outflow vector [ft^3/s]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function q = q_outlet( x, u, R )

Cd = 0.61;  % discharge coefficient
g = 32.2;   % acceleration due to gravity [ft/s^2]
Z = 1;      % outlet elevation measured from pond base [ft]
%R = 1/3;    % outlet radius

q_forBigX = (Cd*pi*R^2) .* u .* sqrt( (2*g) .* (x-Z) ); 
    
q_forSmallX = 0;
    
q = ( x >= Z ).*q_forBigX + ( x < Z ).*q_forSmallX;

end