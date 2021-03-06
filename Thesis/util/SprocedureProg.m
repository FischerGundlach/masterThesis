function [solution,objective,options] = SprocedureProg(poly,system,...
    inequalities,equalities,deg,degP,options)
%SPROCEDUREPROG Sets up S-procedure programm in order to proof 
% positive semi-definiteness of poly on the domain constrainned by
% the set of inequalities. SOS/SDSOS/DSOS are raised to degree deg
%
%   returns solution and returns a cell with entries the DD matrixes
%   Detailed explanation goes here

    if nargin < 5
        options = [];
    end
    [indet,~,~] = decomp([poly; inequalities.'; equalities.']);

    %initiate program
    prog = spotsosprog;
    prog = prog.withIndeterminate(indet);

    %set up DSOS multipliers for inequalities
    z = monomials(indet,0:deg);
    [prog,DSOSPoly,~] = newDSOSPoly(prog,z,length(inequalities));
    S = DSOSPoly.'*inequalities.';

    %set up free multipliers for equalities
    zP = monomials(indet,0:degP);
    if ~length(equalities) == 0
        [prog,FreePoly,~] = newFreePoly(prog,zP,length(equalities));
        P = FreePoly.'*equalities.';
    else
        P = 0;
    end
    
    %Add slack to optimization problem to increase numerical robustness
    [prog,objective,slack,options] = objectiveROAProgDSOS(prog,system,options);
    
    %DSOS constraint
    prog = prog.withDSOS((poly-S-P-slack));

    %set solver and its options
    [solver,spotOptions,options] = solverOptionsPSDProg(options);

    % Solve program
    solution = prog.minimize(objective, solver, spotOptions);
    
end

