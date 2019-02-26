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
% OUTPUT: plots of U(y,r), S(y,r) as well as
    % U{l_index}{r_index} = U(y,r), where y = ls(l_index), r = rs(r_index)
    % S{l_index}{r_index} = S(y,r), where y = ls(l_index), r = rs(r_index)
% NOTE: xtick labels are hard-coded. Should be a function of xs
% AUTHOR: Margaret Chapman
% DATE: August 30, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ U, S ] = getRiskySets( ls, xs, rs, m, J0_cost_sum, J0_cost_max )

nl = length(ls); % # discretized confidence levels

nr = length(rs); % # discretized risk levels

U = cell(nr, nl); S = U; figure; FigureSettings;

for r_index = 1 : nr, r = rs(r_index); subplot(1, nr, r_index);
    
    for l_index = 1 : nl, y = ls(l_index); U_ry = []; S_ry = []; 

        for x_index = 1 : length(xs)
    
            if J0_cost_sum(l_index, x_index) < exp(m*r), U_ry = [ U_ry, xs(x_index) ]; end
    
            if J0_cost_max(l_index, x_index) < r,        S_ry = [ S_ry, xs(x_index) ]; end
    
        end
        
        if ~isempty(U_ry), plot(U_ry, ones(size(U_ry))*y, '*r'); hold on; end; U{r_index}{l_index} = U_ry;
    
        plot(S_ry, ones(size(S_ry))*y, 'ob', 'linewidth', 1); hold on; S{r_index}{l_index} = S_ry;
        
    end
    
    if r_index==1, ylabel('Confidence level, y'); end; title(['r = ', num2str(r)]); xlabel('State, x');
    
    axis([min(xs) max(xs) min(ls) max(ls)]); grid on; yticks(sort(ls)); xticks(xs);
    
    xticklabels({'1','','','','','1.5','','','','','2','','','','','2.5','','','','','3',... % hard-coded
                     '','','','','3.5','','','','','4','','','','','4.5','','','','','5'});    
end
legend('x \in U_y^r','x \in S_y^r');
    



