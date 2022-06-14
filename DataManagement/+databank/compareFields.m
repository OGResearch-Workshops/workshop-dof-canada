
% >=R2019b
%(
function [success, info] = compareFields(d1, d2, opt)

arguments
    d1 (1, 1) {validate.databank(d1)}
    d2 (1, 1) {validate.databank(d2)}

    opt.AbsTol = 1e-12
    opt.Keys = @all
    opt.Error = false
    opt.Warning = false
end
%)
% >=R2019b


% <=R2019a
%{
function [success, info] = compareFields(d1, d2, varargin)

persistent ip
if isempty(ip)
    ip = inputParser();
    addParameter(ip, 'AbsTol', 1e-12);
    addParameter(ip, 'Keys', @all);
    addParameter(ip, 'Error', false);
    addParameter(ip, 'Warning', false);
end
parse(ip, varargin{:});
opt = ip.Results;
%}
% <=R2019a


success = true;
info = struct( );
info.FieldNamesMatch = true;
info.ClassesNotEqual = string.empty(1, 0);
info.DimensionsNotEqual = string.empty(1, 0);
info.SeriesStartDatesNotEqual = string.empty(1, 0);
info.SeriesDataNotEqual = string.empty(1, 0);
info.NumericDataNotEqual = string.empty(1, 0);
info.OtherDataNotEqual = string.empty(1, 0);

keys1 = databank.fieldNames(d1);
keys2 = databank.fieldNames(d2);

if isequal(opt.Keys, @all)
    info.FieldNamesMatch = isequal(sort(keys1), sort(keys2));
    keys = keys1;
else
    opt.Keys = reshape(string(opt.Keys), 1, [ ]);
    info.FieldNamesMatch = all(ismember(opt.Keys, keys1)) && all(ismember(opt.Keys, keys2));
    keys = opt.Keys;
end

success = info.FieldNamesMatch;

if success
    for k = keys1
        field1 = d1.(k);
        field2 = d2.(k);
        if ~isequal(class(field1), class(field2))
            info.ClassesNotEqual(end+1) = k;
            success = false;
            continue
        end

        if ~isequal(size(field1), size(field2))
            info.DimensionsNotEqual(end+1) = k;
            success = false;
            continue
        end

        if isa(field1, 'TimeSubscriptable') && isa(field2, 'TimeSubscriptable')
            if ~dater.eq(field1.Start, field2.Start)
                info.SeriesStartDatesNotEqual(end+1) = k;
                success = false;
                continue
            end
            if maxabs(field1.Data, field2.Data)>opt.AbsTol
                info.SeriesDataNotEqual(end+1) = k;
                success = false;
                continue
            end
        elseif isnumeric(field1) && isnumeric(field2)
            if maxabs(field1, field2)>opt.AbsTol
                info.NumericDataNotEqual(end+1) = k;
                success = false;
                continue
            end
        else
            if ~isequaln(field1, field2)
                info.OtherDataNotEqual(end+1) = k;
                success = false;
                continue
            end
        end
    end
end

if ~success
    if isequal(opt.Error, true)
        exception.error([
            "Databank:FieldsFailToMatch"
            "Databank comparison failed."
        ]);
    elseif isequal(opt.Warning, true);
        exception.warning([
            "Databank:FieldsFailToMatch"
            "Databank comparison failed."
        ]);
    end
end

end%

