function [Qset] = evalMultipliers(sol)
%EVALROAPROG This function evaluates solutions from ROAProg
%   Detailed explanation goes here
    if ~isempty(sol.gramMatrices) 
       
        for i=1:length(sol.gramMatrices)
            Qset{i} = double(sol.eval(sol.gramMatrices{i}));
        end
        
        if ~isempty(sol.prog.coneVar)
            i = i+1; %appends coneVar at the end
            Qset{i} = diag(double(sol.eval(sol.prog.coneVar)));
        end
        
    else
        
        if ~isempty(sol.prog.coneVar) 
            Qset = diag(double(sol.eval(sol.prog.coneVar)));
        end
        
    end
    

    



