function rho_try = step(solution,rho_failed,options)
%STEP Implements step for line search.

switch options
    
    case 'random'
        h = 2*rand*0.01;
        
    case 'determined'
        h = 0.01;
        
    otherwise 
        warning(['lineSearchMethodOption is not'...
            'supported. Change to random.']);
        h = 2*rand*0.001;
        
end

if (rho_failed == solution.rho_extr) 
    rho_try = solution.rho+h;
else
    if (rho_failed > solution.rho)
        rho_try = rho_failed+h;
    else
        rho_try = solution.rho+h;
    end
end

end

