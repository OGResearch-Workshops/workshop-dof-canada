% varobj  Superclass for VAR based model objects.
%
% Backend IRIS class.
% No help provided.

% -IRIS Macroeconomic Modeling Toolbox.
% -Copyright (c) 2007-2017 IRIS Solutions Team.

classdef varobj < shared.UserDataContainer & shared.GetterSetter
    properties
        % YNames  Names of endogenous variables
        YNames = cell.empty(1, 0) 

        % ENames  Names of forecast errors
        ENames = @auto

        % XNames  Names of exogenous variables
        XNames = cell.empty(1, 0)
        
        % INames  Names of conditioning variables
        INames = cell.empty(1, 0) 

        % IEqtn  Expressions for conditioning variables
        IEqtn = cell.empty(1, 0) 

        % A  Transition matrices
        A = double.empty(0) 

        % K  Constant vector
        K = double.empty(0, 1)

        T = double.empty(0) % Schur quasitriangular matrix
        U = double.empty(0) % Schur unitary matrix

        % Zi  Measurement matrx for conditioning variables
        Zi = double.empty(0)

        % X0  Asymptotic mean assumption for exogenous variables
        X0 = zeros(0, 1)

        % J  Coefficient matrix for exogenous variables
        J = zeros(0)

        Omega = double.empty(0) % Covariance matrix of reduced-form residuals
        EigVal = double.empty(1, 0) % Eigenvalues
        EigenStability = int8.empty(1, 0) % Stability of eigenvalues
        
        Range = double.empty(1, 0) % Estimation range
        IxFitted = logical.empty(1, 0) % Index of periods actually fitted
        
        GroupNames = cell.empty(1, 0) % Groups in panel objects

        Reporting = rpteq.empty(1, 0) % Reporting equations
    end
    

    properties (Dependent)
        NumVariants
        EigenValues
        AllNames
        NamesEndogenous
        NamesErrors
        NamesExogenous
        NamesConditioning
        NamesGroups
        NamesReporting
        NumEndogenous
        NumErrors
        NumExogenous
        NumConditioning
        NumGroups
        NumReporting
    end


    properties (Constant)
        EIGEN_TOLERANCE = eps( )^(5/9)
        PREFIX_ERRORS = 'res_'
    end

    
    methods
        varargout = assign(varargin)
        varargout = datarequest(varargin)
        varargout = horzcat(varargin)
        varargout = isempty(varargin)
        varargout = ispanel(varargin)
        varargout = nfitted(varargin)
        varargout = schur(varargin)
        varargout = length(varargin)
    end
    
    
    methods (Hidden)
        function flag = chkConsistency(this)
            flag = chkConsistency@shared.GetterSetter(this) && ...
                chkConsistency@shared.UserDataContainer(this);
        end

        
        disp(varargin)
        varargout = myoutpdata(varargin)
        varargout = myselect(varargin)
        varargout = implementGet(varargin)
        varargout = vertcat(varargin)
    end
    
    
    
    
    methods (Access=protected, Hidden)
        varargout = mycompatible(varargin)
        varargout = mygroupmethod(varargin)
        varargout = mygroupnames(varargin)
        varargout = myny(varargin)
        varargout = myprealloc(varargin)
        varargout = subsalt(varargin)
        varargout = specdisp(varargin)
    end
    
    
    
    
    methods (Static, Hidden)
        varargout = loadobj(varargin)
        varargout = mytelltime(varargin)
    end
    
    
    
    
    methods
        function this = varobj(varargin)
            persistent INPUT_PARSER
            if isempty(INPUT_PARSER)
                INPUT_PARSER = extend.InputParser('varobj.varobj');
                INPUT_PARSER.addRequired('EndogenousNames', @(x) ischar(x) || iscellstr(x) || isa(x, 'string'));
                INPUT_PARSER.addParameter('Comment', '', @(x) ischar(x) || (isa(x, 'string') && isscalar(x)));
                INPUT_PARSER.addParameter({'ExogenousNames', 'Exogenous'}, cell.empty(1, 0), @(x) ischar(x) || iscellstr(x) || isa(x, 'string'));
                INPUT_PARSER.addParameter({'GroupNames', 'Groups'}, cell.empty(1, 0), @(x) ischar(x) || iscellstr(x) || isa(x, 'string'));
                INPUT_PARSER.addParameter('Reporting', cell.empty(1, 0), @(x) ischar(x) || iscellstr(x) || isa(x, 'string'));
                INPUT_PARSER.addUserDataOption( );
                INPUT_PARSER.addBaseYearOption( );
            end

            if isempty(varargin)
                return
            end
            
            if length(varargin)==1 && isa(varargin, 'varobj')
                this = varargin{1};
                return
            end
            
            INPUT_PARSER.parse(varargin{:});

            % Create Reporting before all other names so that AllNames
            % include reporting names when checking for uniqueness
            reportingFiles = INPUT_PARSER.Results.Reporting;
            if ~iscellstr(reportingFiles)
                reportingFiles = cellstr(reportingFiles);
            end
            if ~isempty(reportingFiles)
                for i = 1 : numel(reportingFiles)
                    this.Reporting(1, end+1) = rpteq(reportingFiles{i});
                end
            end

            opt = INPUT_PARSER.Options;
            this.NamesEndogenous = INPUT_PARSER.Results.EndogenousNames;
            this.NamesErrors = @auto;
            this.NamesExogenous = opt.ExogenousNames;
            this.GroupNames = opt.GroupNames;
            this.UserData = opt.UserData;
            this.BaseYear = opt.BaseYear;
        end
    end


    methods
        function x = get.EigenValues(this)
            x = this.EigVal;
        end


        function names = get.AllNames(this)
            names = [ ...
                this.NamesEndogenous, ...
                this.NamesExogenous, ...
                this.NamesErrors, ...
                this.NamesConditioning, ...
                this.NamesReporting, ...
            ];
        end


        function names = get.NamesEndogenous(this)
            names = this.YNames;
            if isempty(names)
                names = cell.empty(1, 0);
            end
        end


        function names = get.NamesErrors(this)
            names = this.ENames;
            if isequal(names, @auto)
                names = strcat(this.PREFIX_ERRORS, this.NamesEndogenous);
            elseif isempty(names)
                names = cell.empty(1, 0);
            end
        end


        function names = get.NamesExogenous(this)
            names = this.XNames;
            if isempty(names)
                names = cell.empty(1, 0);
            end
        end


        function names = get.NamesConditioning(this)
            names = this.INames;
            if isempty(names)
                names = cell.empty(1, 0);
            end
        end


        function names = get.NamesGroups(this)
            names = this.GroupNames;
            if isempty(names)
                names = cell.empty(1, 0);
            end
        end


        function names = get.NamesReporting(this)
            if isempty(this.Reporting)
                names = cell.empty(1, 0);
                return
            end
            names = [this.Reporting(:).NameLhs];
        end


        function num = get.NumVariants(this)
            num = length(this);
        end


        function num = get.NumEndogenous(this)
            num = numel(this.YNames);
        end


        function num = get.NumErrors(this)
            num = this.NumEndogenous;
        end


        function num = get.NumExogenous(this)
            num = numel(this.XNames);
        end


        function num = get.NumConditioning(this)
            num = numel(this.INames);
        end


        function num = get.NumGroups(this)
            num = numel(this.GroupNames);
        end


        function this = set.NamesEndogenous(this, newNames)
            numEndogenous = this.NumEndogenous;
            if ischar(newNames)
                newNames = regexp(newNames, '\w+', 'match');
            elseif isa(newNames, 'string')
                newNames = cellstr(newNames);
            end
            numNewNames = numel(newNames);
            assert( ...
                numEndogenous==0 || numNewNames==numEndogenous, ...
                'varobj:set:NamesEndogenous', ...
                'Illegal number of names for endogenous variables.' ...
            );
            this.YNames = newNames;
            checkNames(this);
        end


        function this = set.NamesErrors(this, newNames)
            if ischar(newNames)
                newNames = regexp(newNames, '\w+', 'match');
            elseif isa(newNames, 'string')
                newNames = cellstr(newNames);
            end
            assert( ...
                isequal(newNames, @auto) ...
                    || numel(newNames)==this.NumNamesEndogenous, ...
                'varobj:set:NamesErrors', ...
                'Illegal number of names for error terms.' ...
            );
            this.ENames = newNames;
            checkNames(this);
        end

            
        function this = set.NamesExogenous(this, newNames)
            if isempty(newNames)
                newNames = cell.empty(1, 0);
            end
            numExogenous = this.NumExogenous;
            if ischar(newNames)
                newNames = regexp(newNames, '\w+', 'match');
            elseif isa(newNames, 'string')
                newNames = cellstr(newNames);
            end
            numNewNames = numel(newNames);
            assert( ...
                numExogenous==0 || numNewNames==numExogenous, ...
                'varobj:set:NamesExogenous', ...
                'Illegal number of names for exogenous variables.' ...
            );
            this.XNames = newNames;
            checkNames(this);
        end


        function this = set.NamesConditioning(this, newNames)
            if isempty(newNames)
                this.INames = cell.empty(1, 0);
                return
            end
            this.INames = newNames;
            checkNames(this);
        end


        function checkNames(this)
            checkValid(this);
            checkPrefix(this);
            checkUnique(this);
        end


        function checkValid(this)
            allNames = this.AllNames;
            indexValid = true(size(allNames));
            for i = 1 : numel(allNames)
                indexValid = isvarname(allNames{i});
            end
            assert( ...
                all(indexValid), ...
                'varobj:checkValid', ...
                'This is not a legal name for variables or error terms: %s ', ...
                allNames{~indexValid} ...
            );
        end


        function checkPrefix(this)
            lenPrefix = length(this.PREFIX_ERRORS);
            % Check names of endogenous variables
            namesEndogenous = this.NamesEndogenous;
            indexEndogenousStartsWithPrefix = strncmp( ...
                namesEndogenous, this.PREFIX_ERRORS, lenPrefix ...
            );
            assert( ...
                ~any(indexEndogenousStartsWithPrefix), ...
                'varobj:checkPrefix', ...
                'This endogenous variable name starts with a reserved prefix: %s ', ...
                namesEndogenous(indexEndogenousStartsWithPrefix) ...
            );
            % Check names of exogenous variables
            namesExogenous = this.NamesExogenous;
            indexExogenousStartsWithPrefix = strncmp( ...
                namesExogenous, this.PREFIX_ERRORS, lenPrefix ...
            );
            assert( ...
                ~any(indexExogenousStartsWithPrefix), ...
                'varobj:checkPrefix', ...
                'This exogenous variable name starts with a reserved prefix: %s ', ...
                namesExogenous(indexExogenousStartsWithPrefix) ...
            );
            % Check names of conditioning variables
            namesConditioning = this.NamesConditioning;
            indexConditioningStartsWithPrefix = strncmp( ...
                namesConditioning, this.PREFIX_ERRORS, lenPrefix ...
            );
            assert( ...
                ~any(indexConditioningStartsWithPrefix), ...
                'varobj:checkPrefix', ...
                'This conditioning variable name starts with a reserved prefix: %s ', ...
                namesConditioning(indexConditioningStartsWithPrefix) ...
            );
        end


        function checkUnique(this)
            allNames = this.AllNames;
            x = tabulate(allNames);
            indexUnique = [x{:, 2}]<=1;
            assert( ...
                all(indexUnique), ...
                exception.Base('VAR:NonuniqueName', 'error'), ...
                allNames{~indexUnique} ...
            );
        end
    end
end
