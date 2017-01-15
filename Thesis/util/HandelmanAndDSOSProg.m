% TO DO:    add possibility to switch between multipliers
%           add possibility to chose obj. function
%           add possibility to pass solver options
%           add additional argout which specifies the decision var.
%           test what happens if indet are called z (like monomials)
%           test weather inequalities indet. match poly indet. 

function [solution,lambda] = HandelmanAndDSOSProg(poly,inequalities,deg)
%HandelmanAndDSOS Sets up Handelman programm constrained to DSOS 
% in order to proof 
% positive semi-definiteness of poly on the domain constrainned by
% the set of inequalities. SOS/SDSOS/DSOS are raised to degree deg
%
%   returns solution and returns a cell with entries the DD matrixes
%   Detailed explanation goes here

    [indet,~,~] = decomp(poly);
    mMonoid = multiplicativeMonoid(inequalities, deg);
    
    %initiate program
    prog = spotsosprog;
    prog = prog.withIndeterminate(indet);
    
    % add nonlinear multipliers
    [prog,lambda] = prog.newPos(length(mMonoid));
    prog = prog.withDSOS(poly-lambda.'*mMonoid);
    
    % options
    options = spot_sdp_default_options();
    % Solve program
    solution = prog.minimize(sum(lambda),@spot_gurobi, options); 
    
end
