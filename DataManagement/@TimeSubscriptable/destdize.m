% destdize  Destandardize time series by multiplying it by std dev and adding mean
%
% __Syntax__
%
%     x = destdize(x, meanX, stdX)
%
%
% __Input Arguments__
%
% * `x` [ TimeSubscriptable ] - Input TimeSubscriptable object.
%
% * `meanX` [ numeric ] - Mean that will be added the data.
%
% * `stdX` [ numeric ] - Standard deviation that will be added to the data.
%
%
% __Output Arguments__
%
% * `x` [ TimeSubscriptable ] - Destandardized output data.
%
%
% __Description__
%
%
% __Example__
%

function this = destdize(this, meanX, stdX)

persistent ip
if isempty(ip)
    ip = extend.InputParser();
    ip.addRequired('inputSeries', @(x) isa(x, 'TimeSubscriptable'));
    ip.addRequired('meanX', @isnumeric);
    ip.addRequired('stdX', @isnumeric);
end
ip.parse(this, meanX, stdX);

sizeData = size(this.Data);
sizeMean = size(meanX);
sizeStd = size(stdX);
errorId = [class(this), 'destdize'];

assert( ...
    isscalar(meanX) || (ndims(this.Data)==ndims(meanX) && all(sizeData(2:end)==sizeMean(2:end))), ...
    errorId, ...
    'Dimension mismatch between input time series and mean.' ...
);

assert( ...
    isscalar(stdX) || (ndims(this.Data)==ndims(stdX) && all(sizeData(2:end)==sizeStd(2:end))), ...
    errorId, ... 
    'Dimension mismatch between input time series and std deviation.' ...
)

this = unop(@series.destdize, this, 0, meanX, stdX);

end%

