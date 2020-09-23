% getEquationsUsingTerminal  Analyze equations reaching into the terminal
% condition and get terminal data points needed to be evaluated in the
% block
% 
% Backend [IrisToolbox] method
% No help provided

% -[IrisToolbox] for Macroeconomic Modeling
% -Copyright (c) 2007-2020 [IrisToolbox] Solutions Team

function getTerminalDataPoints(this, sizeYXEPG)

columnsToRun = this.ParentBlazer.ColumnsToRun;
sh0 = this.ParentBlazer.Incidence.PosOfZeroShift;
numEquations = numel(this.IdEquations);
incEquationsShifts = across(this.ParentBlazer.Incidence, "Quantities");
maxLeads = zeros(1, numEquations);
for i = 1 : numEquations
    ptrEquation = real(this.IdEquations(i));
    maxLeads(i) = find(incEquationsShifts(ptrEquation, :), 1, "last") - sh0;
end

%
% Index of equations that reach into the terminal condition
%
this.InxEquationsUsingTerminal = (imag(this.IdEquations) + maxLeads) > columnsToRun(end);


%
% Find out which data points are actually needed in the
% terminal condition
%
% Cycle over all equations that reach into the terminal
% condition, and over all columns from which the respective
% equation reaches into the terminal condition, and layer the
% incidence of the variables in them (correctly adjusted for
% the column being executed) in an incidence array. From there,
% look up all data points needed.
%

inxTerminalDataPoints = logical(sparse(sizeYXEPG(1), sizeYXEPG(2)));

if this.NeedsTerminal
    for i = find(this.InxEquationsUsingTerminal)
        ptrEquation = real(this.IdEquations(i));
        column = imag(this.IdEquations(i));
        inc = across(selectEquation(this.ParentBlazer.Incidence, ptrEquation), "equations");
        inc = inc(:, sh0+1:end);
        n = size(inc, 2);
        for j = columnsToRun(end)-maxLeads(i)+1:columnsToRun(end)
            inxTerminalDataPoints(:, j+(1:n)) ...
                = inxTerminalDataPoints(:, j+(1:n)) | inc;
        end
    end
    inxTerminalDataPoints(:, 1:columnsToRun(end)) = false;
end

this.InxTerminalDataPoints = inxTerminalDataPoints;

end%

