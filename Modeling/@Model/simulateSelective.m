function [exitFlag, dcy] = simulateSelective( this, simulateFunction, ...
                                              rect, data, needsStoreE, header, ...
                                              solverOptions, window )
% simulateSelective  Run equations-selective simulation on one time frame
%
% Backend IRIS function
% No help provided

% -IRIS Macroeconomic Modeling Toolbox
% -Copyright (c) 2007-2019 IRIS Solutions Team

MAX_DENSITY = 1/3;
MAX_NUM_OF_ELEMENTS = 2e6;

%--------------------------------------------------------------------------

deviation = data.Deviation;
hashEquations = rect.HashEquationsFunction;
firstColumnOfTimeFrame = data.FirstColumnOfTimeFrame;
inxE = data.InxOfE;
inxYX = data.InxOfYX;
numYX = nnz(inxYX);
inxLogYX = data.InxOfLog(inxYX);
solverName = solverOptions(1).SolverName;

columnRangeOfHashFactors = firstColumnOfTimeFrame + (0 : window-1);

tempE = data.AnticipatedE;
tempE(:, firstColumnOfTimeFrame) = tempE(:, firstColumnOfTimeFrame) ...
                                 + data.UnanticipatedE(:, firstColumnOfTimeFrame);

if data.NumOfExogenizedPointsY==0
    %
    % No need to simulate measurement equations in the interim iterations
    % (before the final run) if there are no exogenized measurement
    % variables
    %
    rect.SimulateY = false;
end

objectiveFunction = @objectiveFunctionFull;
%
% Calculate the density of the matrix indicating the variables occurring in
% nonlinear equations; run the multiplier type of simulation only if the
% density is smaller than a cut-off.
%
if data.NumOfExogenizedPoints==0
    hereGetHashIncidence( );
    lastHashedYX = data.LastHashedYX;
    columnRangeOfHashedYX = firstColumnOfTimeFrame : lastHashedYX;
    inxHashedYX = data.InxOfHashedYX(:, columnRangeOfHashedYX);
    density = nnz(inxHashedYX) / numel(inxHashedYX);
    numElements = nnz(inxHashedYX) * rect.NumOfHashEquations * data.Window;
    if  density<MAX_DENSITY || numElements<MAX_NUM_OF_ELEMENTS
        %
        % Run the nonlinear simulations by precalculating the hash multipliers
        % and calculating the incremental impact of the nonlin addfactors on
        % the affected variables only if the density of the affected
        % variables is less than a threshold; otherwise, the performance is
        % likely to deteriorate rather than improve
        %
        calculateHashMultipliers(rect, data);
        numHashedColumns = numel(columnRangeOfHashedYX);
        simulateFunction(rect, data);
        objectiveFunction = @objectiveFunctionShort;
    end
end

initNlaf = data.NonlinAddf(:, columnRangeOfHashFactors);

if strncmpi(solverName, 'IRIS', 4)
    % IRIS Solver
    data0 = data;
    initNlaf0 = initNlaf;
    for i = 1 : numel(solverOptions)
        ithSolver = solverOptions(i);
        if i>1 && ithSolver.Reset
            data = data0;
            initNlaf = initNlaf0;
        end
        [finalNlaf, dcy, exitFlag] = solver.algorithm.qnsd(objectiveFunction, initNlaf, ithSolver, header);
        if hasSucceeded(exitFlag)
            break
        end
    end

elseif strcmpi(solverName, 'fminsearch')
    % Plain fminsearch
    temp = @(x) sum(power(objectiveFunction(x), 2), [1, 2]);
    [finalNlaf, dcy, exitFlag] = fminunc(temp, initNlaf, solverOptions);
    if exitFlag==1
        exitFlag = solver.ExitFlag.CONVERGED;
    elseif exitFlag==0
        exitFlag = solver.ExitFlag.MAX_ITER_FUN_EVALS;
    else
        exitFlag = solver.ExitFlag.OBJ_FUN_FAILED;
    end

else
    if strcmpi(solverName, 'fsolve')
        % Optimization Tbx
        [finalNlaf, dcy, exitFlag] = fsolve(objectiveFunction, initNlaf, solverOptions);
    elseif strcmpi(solverName, 'lsqnonlin')
        % Optimization Tbx
        [finalNlaf, ~, dcy, exitFlag] = lsqnonlin(objectiveFunction, initNlaf, [ ], [ ], solverOptions);
    end
    exitFlag = solver.ExitFlag.fromOptimTbx(exitFlag);
end

rect.SimulateY = true;
data.NonlinAddf(:, columnRangeOfHashFactors) = finalNlaf; 
simulateFunction(rect, data);

return




    function dcy = objectiveFunctionFull(nlaf)
        data.NonlinAddf(:, columnRangeOfHashFactors) = nlaf;
        simulateFunction(rect, data);
        tempYXEPG = data.YXEPG;

        if needsStoreE
            tempE = data.AnticipatedE;
            tempE(:, firstColumnOfTimeFrame) = tempE(:, firstColumnOfTimeFrame) ...
                                             + data.UnanticipatedE(:, firstColumnOfTimeFrame);
        end
        tempYXEPG(inxE, :) = tempE;

        if deviation
            tempYX = tempYXEPG(inxYX, :);
            tempYX(~inxLogYX, :) = tempYX(~inxLogYX, :)  + data.BarYX(~inxLogYX, :);
            tempYX(inxLogYX, :)  = tempYX(inxLogYX, :)  .* data.BarYX(inxLogYX, :);
            tempYXEPG(inxYX, :) = tempYX;
        end
        dcy = hashEquations(tempYXEPG, columnRangeOfHashFactors, data.BarYX);
    end%




    function dcy = objectiveFunctionShort(nlaf)
        % Simulated data with zero hash factors
        tempYXEPG = data.YXEPG;

        % Calculate impact of current hash factors and add them to
        % simulated data
        impact = zeros(numYX, numHashedColumns);
        impact(inxHashedYX) = rect.HashMultipliers * (nlaf(:) - initNlaf(:));
        if any(inxLogYX)
            impact(inxLogYX, :) = exp( impact(inxLogYX, :) );
        end

        tempYX = tempYXEPG(inxYX, columnRangeOfHashedYX);
        tempYX(~inxLogYX, :) = tempYX(~inxLogYX, :)  + impact(~inxLogYX, :);
        tempYX(inxLogYX, :)  = tempYX(inxLogYX, :)  .* impact(inxLogYX, :);
        tempYXEPG(inxYX, columnRangeOfHashedYX) = tempYX;

        tempYXEPG(inxE, :) = tempE;

        if deviation
            tempYX = tempYXEPG(inxYX, :);
            tempYX(~inxLogYX, :) = tempYX(~inxLogYX, :)  + data.BarYX(~inxLogYX, :);
            tempYX(inxLogYX, :)  = tempYX(inxLogYX, :)  .* data.BarYX(inxLogYX, :);
            tempYXEPG(inxYX, :) = tempYX;
        end
        dcy = hashEquations(tempYXEPG, columnRangeOfHashFactors, data.BarYX);
    end%




    function hereGetHashIncidence( )
        TYPE = @int8;
        inc = across(rect.HashIncidence, 'Equations');
        inc = inc(inxYX, :);
        shifts = rect.HashIncidence.Shift;
        inxHashedYX = false(numYX, data.NumOfColumns);
        for ii = columnRangeOfHashFactors
            columnRange = ii + shifts;
            inxHashedYX(:, columnRange) = inxHashedYX(:, columnRange) | inc;
        end
        data.InxOfHashedYX = inxHashedYX;
    end%
end%

