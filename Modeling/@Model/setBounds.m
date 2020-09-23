% setBounds  Set bounds for model quantities
%{
% Syntax
%--------------------------------------------------------------------------
%
%     model = setBounds(input, boundsStruct)
%     model = setBounds(input [, name, bounds])
%
%
% Input Arguments
%--------------------------------------------------------------------------
%
% __`model`__ [ Model ]
%
%>    Model object in which the bounds for selected quantities will be
%>    changed.
%
%
% __`boundsStruct`__ [ struct ]
%
%>    Struct from which the new bounds will be assigned; each field name in the
%>    struct must be a valid `model` name, and its value must be a numeric
%>    vector of up to 4 values.
%
%
% __`name`__ [ stringk ]
%
%>    Valid `model` name.
%
%
% __`value`__ [ numeric ] 
%
%>    Numeric vector of up to 4 values: a lower bound for the level of the
%>    respective quantity, an upper bound for the level, a lower bound for
%>    the change in the quantity (used only in the `steady` function), and
%>    an upper bound for the change (used only in the `steady` function).
%
%
% Output Arguments
%--------------------------------------------------------------------------
%
% __`model`__ [ ]
%
%>    Model object with the new bounds assigned.
%
%
% Description
%--------------------------------------------------------------------------
%
%
% Example
%--------------------------------------------------------------------------
%
%}

% -[IrisToolbox] for Macroeconomic Modeling
% -Copyright (c) 2007-2019 [IrisToolbox] Solutions Team


function this = setBounds(this, varargin)

this.Quantity = setBounds(this.Quantity, varargin{:});

end%

