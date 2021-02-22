% databank.fromIMF.data  Download time series from IMF Data Portal
%{
% Syntax
%--------------------------------------------------------------------------
%
%     output = databank.fromIMF.data(input, ...)
%
%
% Input Arguments
%--------------------------------------------------------------------------
%
% __``__ [ ]
%
%>    Description
%
%
% Output Arguments
%--------------------------------------------------------------------------
%
% __``__ [ ]
%
%>    Description
%
%
% Options
%--------------------------------------------------------------------------
%
%
% __`=`__ [ | ]
%
%>    Description
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

function [outputDb, info] = data(dataset, freq, areas, items, options, nameOptions)

% >=R2019b
%(
arguments
    dataset (1, 1) string
    freq (1, 1) Frequency {locallyValidateFrequency}
    areas (1, :) string
    items (1, :) string

    options.AddToDatabank (1, 1) {validate.databank} = struct( )
    options.StartDate (1, 1) double {locallyValidateDate(options.StartDate, freq)} = -Inf
    options.EndDate (1, 1) double {locallyValidateDate(options.EndDate, freq)} = Inf
    options.URL (1, 1) string {locallyValidateURL} = "http://dataservices.imf.org/REST/SDMX_JSON.svc/CompactData/"
    options.WebReadOptions = weboptions("TimeOut", 9999)

    nameOptions.IncludeArea (1, 1) logical = true
    nameOptions.AreaSeparator (1, 1) string = "_"
    nameOptions.NameFunc = [ ]
end
%)
% >=R2019b

[areas, areaMap, areasString] = locallyCreateNameMap(areas);
[items, itemMap, itemsString] = locallyCreateNameMap(items);


request = sprintf( ...
    "%s/%s.%s.%s?" ...
    , dataset ...
    , Frequency.toIMFLetter(freq) ...
    , areasString ...
    , itemsString ...
);

if ~isinf(options.StartDate) 
    request = request + "&startPeriod=" + DateWrapper.toIMFString(options.StartDate);
end

if ~isinf(options.EndDate) 
    request = request + "&endPeriod=" + DateWrapper.toIMFString(options.EndDate);
end

outputDb = options.AddToDatabank;

request = options.URL + request;
response = webread(request, options.WebReadOptions);

outputDb = locallyCreateSeriesFromResponse(outputDb, freq, response, request, areaMap, itemMap, nameOptions);

info = struct( );
info.Request = request;
info.Response = response;

end%

%
% Local Functions
%

function outputDb = locallyCreateSeriesFromResponse(outputDb, freq, response, request, areaMap, itemMap, nameOptions)
    try
        allResponseData = response.CompactData.DataSet.Series;
    catch
        exception.error([
            "Databank:IMF:Data:NoObservationsReturned"
            "This request did not return any data: %s"
        ], request);
    end

    isDictionary = isa(outputDb, "Dictionary");
    for i = 1 : numel(allResponseData)
        responseData = hereGetIthReponse( );
        name = hereCreateName( );
        if isstruct(responseData) && isfield(responseData, "Obs")
            [dates, values] = hereGetDatesValues( );
            series = Series(dates, values, "", rmfield(responseData, "Obs"), "--skip");
        else
            series = Series();
        end
        if isDictionary
            store(outputDb, name, series);
        else
            outputDb.(name) = series;
        end
    end

    return

        function responseData = hereGetIthReponse( )
            if iscell(allResponseData)
                responseData = allResponseData{i};
            else
                responseData = allResponseData(i);
            end
        end%


        function name = hereCreateName( )
            area = string(responseData.x_REF_AREA);
            try
                area = areaMap.(area);
            end
            item = string(responseData.x_INDICATOR);
            try
                item = itemMap.(item);
            end
            name = item;
            if nameOptions.IncludeArea
                name = area + nameOptions.AreaSeparator + name;
            end
            if isa(nameOptions.NameFunc, "function_handle")
                name = nameOptions.NameFunc(name);
            end
        end%


        function [dates, values] = hereGetDatesValues( )
            if isstruct(responseData.Obs)
                % Struct array
                if isfield(responseData.Obs, "x_TIME_PERIOD") && isfield(responseData.Obs, "x_OBS_VALUE")
                    dates = {responseData.Obs.x_TIME_PERIOD};
                    values = {responseData.Obs.x_OBS_VALUE};
                else
                    dates = double.empty(0, 1);
                    values = double.empty(0, 1);
                    return
                end
                if isempty(dates) || isempty(values) || numel(dates)~=numel(values)
                    dates = double.empty(0, 1);
                    values = double.empty(0, 1);
                    return
                end
            else
                % Cell array of structs
                dates = cell.empty(0, 1);
                values = cell.empty(0, 1);
                for obs = reshape(responseData.Obs, 1, [ ])
                    try
                        addDates = obs{:}.x_TIME_PERIOD;
                        addValues = obs{:}.x_OBS_VALUE;
                        if isempty(addDates) || isempty(addValues) || numel(addDates)~=numel(addValues)
                            continue
                        end
                        dates = [dates; {addDates}];
                        values = [values; {addValues}];
                    end
                end
            end
            dates = DateWrapper.fromIMFString(freq, string(dates));
            values = double(string(values));
        end%
end%


function [list, map, requestString] = locallyCreateNameMap(list)
    if isempty(list)
        map = list;
        requestString = "";
        return
    end
    map = struct( );
    inx = contains(list, "->");
    if any(inx)
        [inputName, outputName] = textual.split(list(inx), "->");
        inputName = strip(inputName);
        outputName = strip(outputName);
        for i = 1 : numel(inputName)
            map.(inputName(i)) = outputName(i);
        end
        list(inx) = inputName(inx);
    end
    requestString = join(list, "+");
end%

%
% Local Validators
%

function locallyValidateFrequency(freq)
    if any(freq==[Frequency.YEARLY, Frequency.QUARTERLY, Frequency.MONTHLY])
        return
    end
    error("Frequency needs to be one of {YEARLY, QUARTERLY, MONTHLY}.");
end%


function locallyValidateURL(value)
    if endsWith(value, "/") && ~endsWith(value, "//")
        return
    end
    error("Option URL needs to be a string ending with a single forward slash character.");
end%


function locallyValidateDate(date, freq)
    if isinf(date)
        return
    end
    if dater.getFrequency(date)==double(freq)
        return
    end
    error("Options StartDate and EndDate need to be regular dates complying with Frequency.");
end%

