function terminate = terminateBisect(solution,rho_try,rho_failed,~)
%TERMINATEBISECT Summary of this function goes here
%   Detailed explanation goes here

a = 0.001;

terminate = (rho_try-solution.rho <= a && rho_try ~= 0) || ...
            (solution.rho_extr-solution.rho <= a) || ... 
            (rho_failed-solution.rho <= a);

end

