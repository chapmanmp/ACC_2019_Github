%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION: Provides U(y,r), S(y,r) at given confidence level y, risk level r
    % U(y,r) := { x | min_pi CVaR_y[ exp(m*g(x0)) + ... + exp(m*g(xN)) | x0 = x, pi ] < exp(m*r) }
    % S(y,r) := { x | min_pi CVaR_y[ max{ g(x0), ..., g(xN) }          | x0 = x, pi ] < r        }
    % U(y,r) is a subset of S(y,r)
    % g is the signed distance function w.r.t constraint set, K = (2,4)
% INPUT:
    % l_index: index of confidence level
    % ls: discretized confidence levels, vector
    % xs: discretized states, vector
    % rs: discretized risk levels, vector
    % m: soft-max parameter
    % J0_cost_sum(l_index, x_index) = min_pi CVaR_y[ exp(m*g(x0)) + ... + exp(m*g(xN)) | x0 = x, pi ]
    % J0_cost_max(l_index, x_index) = min_pi CVaR_y[ max{g(x0), ..., g(xN)}        | x0 = x, pi ]
        % at y = ls(l_index), x = xs(x_index)
    % beta: small positive number
% OUTPUT: plots of U(y,r), S(y,r) as well as
    % U{r_index}{l_index} = U(y,r), where y = ls(l_index), r = rs(r_index)
    % S{r_index}{l_index} = S(y,r), where y = ls(l_index), r = rs(r_index)
% NOTE: xtick labels are hard-coded. Should be a function of xs
% AUTHOR: Margaret Chapman
% DATE: August 30, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ U, S ] = getRiskySets_pond( ls, xs, rs, m, J0_cost_sum, J0_cost_max, beta, fignum )

nl = length(ls); % # discretized confidence levels

nr = length(rs); % # discretized risk levels

U = cell(nr, nl); S = U; figure(fignum); FigureSettings;

for r_index = 1 : nr, r = rs(r_index); subplot(nr/2, 2, r_index);
    
    for l_index = 1 : nl, y = ls(l_index); U_ry = []; S_ry = []; 

        for x_index = 1 : length(xs)
    
            if J0_cost_sum(l_index, x_index) <= beta*exp(m*r),   U_ry = [ U_ry, xs(x_index) ]; end
    
            if J0_cost_max(l_index, x_index) <= r,               S_ry = [ S_ry, xs(x_index) ]; end
    
        end
        
        if ~isempty(U_ry), plot(U_ry, ones(size(U_ry))*y, '*r'); hold on; end; U{r_index}{l_index} = U_ry;
    
        plot(S_ry, ones(size(S_ry))*y, 'ob', 'linewidth', 1); hold on; S{r_index}{l_index} = S_ry;
        
    end
    % legend placement is hard-coded
    if r_index==2, legend('x \in U_y^r','x \in S_y^r'); end; % put legend for an rs, where U_ry is not empty
    
    title(['r = ', num2str(r)]); xlabel('Water level, x (ft)'); ylabel('Confidence level, y');
    
    % xs(26) = 2.5ft, to remove some white space from graph
    index_xup = 26; xs_short = xs(1: index_xup);
    
    axis([min(xs) max(xs_short) min(ls) max(ls)]); grid on; yticks(sort(ls)); xticks(xs_short);
    
    % hard-coded
    xticklabels({'0','','','','','0.5','','','','','1','','','','','1.5','','','','','2','','','','','2.5'});   
end



