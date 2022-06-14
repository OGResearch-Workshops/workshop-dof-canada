% prepareRectangular  Populate @Rectangular properties derived from @Model
%
% Backend [IrisToolbox] method
% No help provided

% -[IrisToolbox] for Macroeconomic Modeling
% -Copyright (c) 2007-2022 IRIS Solutions Team

function rect = prepareRectangular(this, rect)

rect.Quantity = this.Quantity;
rect.Vector = this.Vector;

[~, maxShift] = getActualMinMaxShifts(this);
rect.HasLeads = maxShift>0;

end%

