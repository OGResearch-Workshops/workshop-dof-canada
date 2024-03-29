
function [A, B, K, J, Zi, Cov] = getIthSystem(this, variantsRequested)

try
    variantsRequested; %#ok<VUNUS>
catch
    variantsRequested = ':';
end


    A = this.A(:, :, variantsRequested);
    [Cov, B] = getResidualComponents(this, variantsRequested);
    K = this.K(:, :, variantsRequested);
    J = this.J(:, :, variantsRequested);

    if nargout<5
        return
    end

    if ischar(variantsRequested) && all(strcmpi(variantsRequested, ':'))
        numVariantsRequested = countVariants(this);
    else
        numVariantsRequested = numel(variantsRequested);
    end

    Zi = this.Zi;
    if isempty(Zi)
        Zi = zeros(0, 1 + this.NumEndogenous*this.Order);
    end
    Zi = repmat(Zi, 1, 1, numVariantsRequested);

end%

