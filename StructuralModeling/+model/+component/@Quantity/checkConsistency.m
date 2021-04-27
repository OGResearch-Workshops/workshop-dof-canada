function flag = checkConsistency(this)
% checkConsistency  Check consistency of model.component.Equation properties
%
% Backend IRIS function
% No help provided

% -IRIS Macroeconomic Modeling Toolbox
% -Copyright (c) 2007-2021 IRIS Solutions Team

%--------------------------------------------------------------------------

numOfQuantities = length(this.Name);

flag = length(this.Type)==numOfQuantities ...
    && isnumeric(this.Type) ...
    && length(this.Label)==numOfQuantities ...
    && iscellstr(this.Label) ...
    && length(this.Alias)==numOfQuantities ...
    && iscellstr(this.Alias) ...
    && length(this.IxLog)==numOfQuantities ...
    && islogical(this.IxLog) ...
    && length(this.IxLagrange)==numOfQuantities ...
    && islogical(this.IxLagrange) ...    
    && length(this.IxObserved)==numOfQuantities ...
    && islogical(this.IxObserved) ...
    && size(this.Bounds,1)==4 ...
    && size(this.Bounds,2)==numOfQuantities ...
    && isnumeric(this.Bounds);

if ~flag
    return
end

flag = numel(this.Name)==numel(unique(this.Name)) ...
    && ~any( strncmp(this.Name, 'std_', 4) ) ...
    && ~any( strncmp(this.Name, 'corr_', 5) ) ...
    && ~any( strcmp(this.Name, model.component.Quantity.RESERVED_NAME_TTREND) ) ...
    && ~any( strcmp(this.Name, model.component.Quantity.RESERVED_NAME_LINEAR) );

end%
