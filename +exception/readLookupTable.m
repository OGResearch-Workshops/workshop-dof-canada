function lookupTable = readLookupTable( )

lookupTable = {
    'General:Internal', 'Internal IRIS error. Please report this error to IRIS Solutions Team.'
    'General:InvalidAssignment', 'Invalid assignment to a %1 object.'
    'General:InvalidInput', 'Expecting input argument <%s> but none found or its value fails validation.'
    'General:InvalidReference', 'Invalid subscripted reference or assignment to a %1 object.'
    'Behavior:DotReferenceFunc', 'Behavior for DotReferenceFunc must be function handle or empty array'
    'Behavior:LogStyleInSolutionVectors', 'This is not valid behavior for LogStyleInSolutionVectors: %s'
    'Blazer:CannotAutoendogenize', 'Cannot autoendogenize this name: %s '
    'Blazer:CannotAutoexogenize', 'Cannot autoexogenize this name: %s '
    'Blazer:CannotEndogenize', 'Cannot endogenize this name: %s '
    'Blazer:CannotExogenize', 'Cannot exogenize this name: %s '
    'Blazer:CannotRunLinear', 'Cannot run Blazer on linear models.'
    'Blazer:NumberEquationsEndogenized', 'Number of endogenized names [%g] fails to match number of equations [%g].'
    'Config:InvalidOptionName', 'This is not a valid IRIS config option: %s '
    'Config:InvalidOptionValue', 'New value for this option failed validation: %s'
    'Config:ProtectedOption', 'This configuration option is not customizable: %s'
    'CovFun:IndexUnitRootsSize', 'Incorrect dimensions of unit root index'
    'Databank:InvalidSeriesId', 'This is not a valid FRED series ID: %s '
    'Databank:FailedToRetrieveData', 'Failed to retrieve data for this series: %s '
    'Databank:CannotDetermineFrequencyFromJson', 'Cannot determine date frequency from FRED JSON file'
    'DataCube:CannotReadTimelessAsSeries', 'Cannot read this timeless name as Series: %s'
    'DataCube:FileExists', 'File with this name already exists; needs to be deleted first before using for DataCube storage: %s'
    'DataCube:OutOfBoundsReference', 'Subscripted reference or assignment to DataCube is out of bounds.'
    'DataCube:NameNotFound', 'This name does not exist in DataCube: %s'
    'DataCube:InvalidReference', 'Invalid subscripted reference or assignment to DataCube; indices must delineate a continuous cube.'
    'DataCube:ReducesToInvalidNumOfRows', 'Reduction function produces invalid number of rows.'
    'DataCube4Model:InconsistentNumOfDataSets', 'Number of data sets in databank is not consistent with number of runs in DataCube4Model object.'
    'DataCube4Model:InvalidDotReference', 'Invalid dot-reference or dot-assignment to DataCube; indices must delineate a continuous cube.'
    'Datafeed:FeedUnknownFrequency', 'Date frequency of this Datafeed series unknown; series not loaded: %s'
    'Dates:CalendarFormatForDaily', 'Calendar date format starting with a ''$'' must be specified for daily frequency dates.'
    'Dates:MixedFrequency', 'Dates with mixed date frequencies are not allowed %1: %s'
    'Dates:OnlyScalarFormatAllowed', 'Only one single DateFormat= allowed in str2dat(~)'
    'Dates:UnrecognizedFrequency', 'Invalid or unrecognized date frequency'
    'Dates:InvalidOutputClass', 'Output class in date creation functions must be DateWrapper or double'
    'Dates:FrequencyMismatch', 'Date frequency mismatch'
    'Dates:NonIntegerSerialNumber', 'Serial number must be integer: %g'
    'Dbase:CannotDetermineRange', 'Cannot determine range because no time series entries have been found in input databank'
    'Dbase:DbfunReportError', 'Error occured when processing this databank entry: %s \n$ENGINE$ says: %s'
    'Dbase:DbfunReportWarning', 'Warning occured when processing this databank entry: %s \n$ENGINE$ says: %s'
    'Dbase:EntrySizeMismatch', 'This databank entry does not match the size of other entries: %s'
    'Dbase:EntryFrequencyMismatch', 'This databank entry does not match the date frequency requested: %s'
    'Dbase:EntryNotSeries', 'This name exists in input databank but is not a time series: %s'
    'Dbase:InvalidLoadFormat', 'This CSV file contains data in invalid format or no delimiter-separated values: %s'
    'Dbase:LoadMixedFrequency', 'This CSV file contains dates with mixed frequencies: %s '
    'Dbase:ErrorLoadingUserData', 'Error when reconstructing user data from this CSV file: %s\nMatlab reports this error:\n%s'
    'Dbase:InvalidOptionNameFunc', 'Option NameFunc= must be function returning text string.'
    'Dbase:NameNotExist', 'This name does not exist in input databank: %s'
    'DateWrapper:InvalidDateFormat', 'Invalid date format; must be char, string, cellstr, or struct'
    'DateWrapper:InvalidInputsIntoPlus', 'Invalid input arguments into a DateWrapper plus expression'
    'DateWrapper:InvalidInputsIntoMinus', 'Invalid input arguments into a DateWrapper minus expression'
    'DateWrapper:InvalidInputsIntoAddTo', 'Invalid input arguments into DateWrapper.addTo(~)'
    'DateWrapper:InvalidInputsIntoRnglen', 'Input arguments into DateWrapper.rnglen(~) must be dates of the same date frequency'
    'DateWrapper:InvalidInputsIntoUminus', 'Unary minus can only be applied to Inf or -Inf dates'
    'DateWrapper:InvalidStartEndInColon', 'Start and end dates in a DateWrapper colon expression must be scalar dates of the the same date frequency'
    'DateWrapper:InvalidStepInColon', 'Step in a DateWrapper colon expression must be a scalar integer'
    'DateWrapper:InvalidInputsIntoDatetime', 'Input arguments into DateWrapper.datetime(~) must be dates of the same date frequency'
    'Distribution:InvalidParameterization', 'This is not a valid type of parameterization for %s distribution: %s'
    'Distribution:Abstract:LowerUpperBounds', 'Lower bound of distribution domain must be below upper bound'
    'Distribution:Abstract:UpperLowerBounds', 'Upper bound of distribution domain must be above lower bound'
    'Dynamic:EvaluatesToNan', 'This dynamic equation evaluates to NaN or Inf in period %1: %s'
    'Equation:InvalidDefinition', 'This definition has an invalid LHS: %s '
    'Equation:InvalidLhsDtrend', 'Invalid LHS in this dtrend equation: %s '
    'Equation:InvalidLhsLink', 'Invalid LHS in this !link equation: %s '
    'Equation:InvalidLhsLinkLock', 'This is not a valid LHS name in !links equations: %s '
    'Equation:InvalidLhsRevision', 'Invalid LHS in this !revisions equation: %s '
    'Equation:InvalidLhsRevisionLock', 'This is not a valid LHS name in !revisions equations: %s '
    'Equation:LhsVariableMustLogInDtrend', 'The LHS variable must be in log in this dtrend equation: %s '
    'Equation:LossFuncDiscountEmpty', 'Loss function discount factor is empty or has umatched bracket: %s '
    'Equation:LossFuncMustBeTransition', 'Loss function min( ) or min#( ) must be a transition equation '
    'Equation:MultipleLhsDtrend', 'Mutliple dtrend equations for this measurement variable: %s '
    'Equation:MultipleLossFunc', 'Multiple loss functions found.'
    'Equation:StdCorrInOtherThanLink', 'Std_ or corr_ name "%s" cannot be used in equations other than dynamic links: %s '
    'Equation:UndeclaredMistypedName', 'Undeclared or mistyped name "%s" in this equation: %s '
    'Frequency:InvalidConversionFromString', 'Invalid conversion from string to Frequency'
    'Frequency:InvalidConversionFromNumeric', 'Invalid conversion from numeric to Frequency'
    'GetterSetter:InvalidGetQuery', 'This is not a valid get query to %1 object: %s '
    'GetterSetter:InvalidSetRequest', 'This is not a valid set request in %1 object: %s'
    'GetterSetter:InvalidSetValue', 'Invalid value in this set request in %1 object: %s'
    'Global:CannotRunLead', 'Cannot run global simulations on models with leads.'
    'Global:EvaluatesToNanInfImag', 'This equation evaluates to a NaN, Inf, or complex number when simulated at t=%1 in P#%2: %s '
    'Global:SolveBlockFailed', 'Global nonlinear simulation stopped prematurely at t=%s in P#%g. \nMax abs discrepancy %g in this equation: %s'
    'Grouping:CannotRemoveGroup', 'The "Other" group cannot be removed'
    'Grouping:NotExistCannotRemove', 'This group does not exist and cannot be removed: %s '
    'Grouping:NotExistCannotSplit', 'This group does not exist and cannot be split: %s '
    'Grouping:InvalidType', 'Invalid grouping type: %s '
    'Grouping:MultipleOccurrence', 'This %1 name is assigned to multiple groups: %s'
    'Grouping:InvalidName', 'This is not a valid %1 name in the grouping object: %s  '
    'Link:LinksNotSequential', 'Dynamic links cannot be reordered sequentially'
    'Model:CannotCatInOtherDim', 'Cannot concatenate model objects other than horizontally; use horizontal concatenation to merge models into multiple parameter variants.'
    'Model:CannotChangeSteadyShocks', 'Steady levels for shocks cannot be changed from zero: %s '
    'Model:CannotCompareTable:Option', 'Compare=true can be only used in models with more than one parameter variant.'
    'Model:CannotSteadyLinear', 'Cannot compute linear steady state because first-order solution is not available: %s'
    'Model:CannotLoadFromMatFile', 'Cannot load model object from MAT file. Recreated model object from its model file.'
    'Model:CannotSetNonzeroCorr', 'Nonzero correlation between measurement and transition shocks is not allowed. '
    'Model:InvalidAssignFlag', 'Invalid assignment flag: %s'
    'Model:InvalidName', 'This is not a valid %1name in the Model object: %s '
    'Model:InvalidQuantityType', 'This is not a valid type of Model object quantities: %s'
    'Model:LogVariableZeroSteady', 'Steady state for this log variable is numerically close to zero: %s '
    'Model:NotDifferenceStationary', 'Model is not difference stationary; some steady-state growth rates are not fixed numbers: %s'
    'Model:NotParameterInEstimationSpecs', 'This name in estimation specs is not a parameter: %s '
    'Model:NumOfColumnsNumOfDraws', 'Options NCol= and NDraw= can be used only in models with a single parameter variant'
    'Model:ParameterNotAssigned', 'This parameter is not assigned: %s '
    'Model:Postparser:DynamicEquationEmpty', 'Dynamic part of this equation is empty: %s '
    'Model:Postparser:ExogenousInOtherThanDtrend', 'Exogenous variables allowed only in deterministic trends: %s '
    'Model:Postparser:LeadOfTransitionInMeasurement', 'Leads of transition variables not allowed in measurement equations: %s '
    'Model:Postparser:MeasurementShift', 'Lags or leads of measurement variables not allowed in any equations: %s '
    'Model:Postparser:MeasurementShockInTransition', 'Measurement shocks not allowed in transition equations: %s '
    'Model:Postparser:MeasurementVariableInTransition', 'Measurement variables not allowed in transition equations: %s '
    'Model:Postparser:MisplacedSteadyReference', 'Misplaced or invalid steady reference in this equation: %s '
    'Model:Postparser:MisplacedTimeSubscript', 'Misplaced or invalid time subscript in this equation: %s'
    'Model:Postparser:NameCannotBeNonnegative', 'This name cannot be declared as nonnegative: %s '
    'Model:Postparser:NoCurrentDateInDynamic', 'No current date for this variable in dynamic equations: %s '
    'Model:Postparser:NoCurrentDateInSteady', 'No current date for this variable in steady equations: %s '
    'Model:Postparser:NoCurrentMeasurement', 'No current dated measurement variable in this measurement equation: %s '
    'Model:Postparser:NoMeasurementVariableInDynamic', 'No measurement variable in this dynamic equation: %s '
    'Model:Postparser:NoMeasurementVariableInSteady', 'No measurement variable in this steady equation: %s '
    'Model:Postparser:NoTransitionEquation', 'No transition equation found in model file.'
    'Model:Postparser:NoTransitionVariable', 'No transition variable found in model file.'
    'Model:Postparser:NoTransitionVariableInDynamic', 'No transition variable in this dynamic equation: %s '
    'Model:Postparser:NoTransitionVariableInSteady', 'No transition variable in this steady equation: %s '
    'Model:Postparser:NumberMeasurementEquationsVariables', 'Number of measurement equations [%g] does not match number of measurement variables [%g].'
    'Model:Postparser:NumberTransitionEquationsVariables', 'Number of transition equations [%g] does not match number of transition variables [%g].'
    'Model:Postparser:OtherThanParameterExogenousInDtrend', 'RHS of this dtrend equation includes names other than parameters or exogenous variables: %s '
    'Model:Postparser:ParameterShift', 'Lags or leads of parameters not allowed in any equations: %s '
    'Model:Postparser:PrefixMultiplier', 'This name starts with a prefix reserved for lagrange multipliers in optimal policy models; change the name: %s '
    'Model:Postparser:ReportingNameConflict', 'This LHS reporting variable name conflicts with existing model name: %s '
    'Model:Postparser:ShockShift', 'Lag or lead of shock(s) in this equation: %s '
    'Model:Postparser:SstateRefInDtrend', 'Steady references not allowed in deterministic trends: %s '
    'Model:Postparser:SstateRefInLinear', 'Steady references in linear models will result in errors unless functions solve( ) and sstate( ) are called with option Linear=false: %s '
    'Model:Postparser:SstateRefInLink', 'Steady references not allowed in dynamic links: %s '
    'Model:Postparser:SyntaxError', 'Syntax error in this equation: %s \n\nMatlab reports this error:\n%s'
    'Model:Postparser:TransitionShockInMeasurement', 'This measurement equation includes transition shock(s): %s '
    'Model:CannotLoadFromMat', 'Cannot load model objects created in older versions of the IRIS Toolbox (prior to %s). Rebuild the model object from its model file.'
    'Model:InconsistentParamData', 'Number of parameter variants [%g] is not consistent with number of data variants [%g]'
    'Model:IndexExceedsVariants', 'Index exceeds the number of parameter variants: %s'
    'Model:InvalidShockName', 'This is not a valid shock name: %s '
    'Model:InvalidVariantName', 'Cannot find parameter variant with this name: %s'
    'Model:MissingInitCond', 'Values for this initial condition are missing from input databank: %s '
    'Model:NoMeasurementData', 'No data for measurement variables found in input databank: %s'
    'Model:NoMeasurementVariables', 'This model has no measurement variables.'
    'Model:RedundantParameter', 'This parameter does not occur in any model equation: %s '
    'Model:RedundantShock', 'This shock does not occur in any model equation: %s '
    'Model:SolutionNotAvailable', 'Model solution(s) not available for these parameter variants: %s'
    'Model:StackedSimulationFailed', 'Some blocks in stacked simulation failed to converge %s'
    'Model:SteadyNotAvailable', 'Steady state is not available for this variable: %s '
    'Model:SteadyErrorInDynamic', 'Steady-state values not consistent with this dynamic equation %s: %s'
    'Model:SteadyErrorInSteady', 'Steady-state values not consistent with this steady equation %s: %s'
    'Model:SteadyInaccurate', 'Steady state inaccurate or not returned for some variables '
    'Model:TableInvalidRequest', 'This is not a valid request into model.table: %s '
    'Model:UnknownInputData', 'Invalid format of input data.'
    'Model:File:CannotOpenTextFile', 'Cannot open this text file for writing: %s '
    'Model:File:CannotWriteToTextFile', 'Cannot write to this text file: %s '
    'Model:MissingExogenized', 'Some values for this exogenized variable are missing from input databank: %s'
    'Obsolete:KeywordUseInstead', 'The keyword %s is obsolete, and will be removed from IRIS in a future version. Use %s instead '
    'Obsolete:ObsoleteMatFile', 'The model object in this MAT file was saved by an older, incompatible IRIS. It will no be possible to load it in a future version. Rebuild the model object from its model file '
    'Obsolete:OptionUseInstead', 'The option %s= is obsolete, and will be removed from IRIS in a future version. Use %s= instead '
    'Obsolete:RexpFlag', 'The "-rexp" flag is not supported any more; use a rexp( ) wrapper instead'
    'Obsolete:Estimate8', 'Calling estimate( ) function with more than 8 output argument is obsolete and will be disallowed in a future version; see documentation '
    'Obsolete:BPassInputs', 'Calling bpass( ) with a date range placed a second input argument is obsolete and will be disallowed in a future version; see documentation '
    'Options:FailsValidation', 'Value assigned to option %s= fails validation: %s'
    'Options:InvalidObsolete', 'Invalid or obsolete option: %s='
    'Pages:Wrapper:InvalidPaperType', 'Invalid paper type: %s'
    'Pages:Wrapper:InvalidOrientation', 'Invalid paper orientation: %s'
    'Pairing:InvalidNamesInDynamicAutoexog', 'This is not a valid pair of names for dynamic autoexog: %s '
    'Pairing:InvalidNamesInSteadyAutoexog', 'This is not a valid pair of names for steady autoexog: %s '
    'Pairing:MultipleLhsAutoexog', 'This name is autoexogenized more than once: %s '
    'Pairing:MultipleRhsAutoexog', 'This name is autoendogenized more than once: %s '
    'Posterior:NoParametersToEstimate', 'There are no parameters to estimate.'
    'Posterior:RepairToHonorBounds', 'Final estimate of this parameter repaired to honor its %1 bound: %s'
    'Posterior:InitialBelowLowerBound', 'Initial value for this parameter fails to honor its lower bound: %s'
    'Posterior:InitialAboveUpperBound', 'Initial value for this parameter fails to honor its upper bound: %s'
    'Posterior:InvalidPriorAtInitial', 'Prior distribution fails at initial value for this parameters: %s'
    'Posterior:InconsistentBounds', 'The lower and upper bounds for this parameter are inconsistent: %s '
    'Preparser:CannotCloseFile', 'Cannot close this file after reading: %s '
    'Preparser:CannotFindFile', 'Cannot find this file: %s '
    'Preparser:CannotOpenFile', 'Cannot open this file for reading: %s '
    'Preparser:CannotSave', 'Cannot save preparsed code to disk file: %s '
    'Preparser:CloneStringInvalid', 'This is not a valid clone string: %s '
    'Preparser:CtrlEvalCaseFailed', 'Error evaluating this !case expression; proceeding to next !case, !otherwise or !end: %s '
    'Preparser:CtrlEvalIfFailed', 'Error evaluating this !if or !elseif condition; assuming false instead: %s '
    'Preparser:CtrlEvalSwitchFailed', 'Error evaluating this !switch expression; proceeding to !otherwise or !end: %s '
    'Preparser:CtrlForMultipleDo', 'This !for block contains multiple !do keywords: %s '
    'Preparser:CtrlLeftover', 'This leftover code found in !switch block: %s '
    'Preparser:CtrlMissingEnd', 'No matching !end found for this control command: %s '
    'Preparser:CtrlMissingFileName', 'Missing or invalid name for this exportable file: %s '
    'Preparser:CtrlObsoleteUpperLower', 'This is obsolete syntax for control variables in !for blocks: %s '
    'Preparser:CtrlUnfinishedCondition', 'This control condition or expression is unfinished: %s '
    'Preparser:ErrorPreparsing', '%s'
    'Preparser:PseudofuncSecondInputFailed', 'Second input argument to this pseudofunction failed to evaluate to a scalar number: %s '
    'Preparser:PseudofuncUnfinished', 'No matching closing braket found for this pseudofunction: %s '
    'Preparser:InterpEvalFailed', 'Error evaluating this pseudosubstitution: %s '
    'Preparser:InvalidDoubledotPattern', 'This is not a valid double-dot pattern: %s '
    'Preparser:SubsLeftover', 'This leftover code found in !substitution block: %s '
    'Preparser:SubsNameMultiple', 'This substitution name is defined more than once: %s '
    'Preparser:SubsUndefined', 'This substitution is not defined: %s '
    'Quantity:CannotUnlog', 'Cannot unlog this name: %s '
    'Quantity:InvalidNameInCurrentContext', 'This is not a valid input name in the current context: %s '
    'Quantity:InvalidStdCorrInLink', 'This is not a valid std_ or corr_ name in a !links equation: %s '
    'Quantity:UserSelectionMustCharCellstr', 'User selection of names must be cellstr or char'
    'Report:InvalidLegendEntries', 'Invalid legend entries'
    'RptEq:InvalidLhs', 'Invalid LHS name in this reporting equation: %s '
    'RptEq:RhsNameDataNotFound', 'This name is not found in input databank: %s '
    'RptEq:RhsNameDataInvalid', 'Input data for this name are invalid: %s '
    'RptEq:SteadyRefNotFoundInModel', 'Name of this steady-state reference is not found in model: %s '
    'Scenario:Wrapper:NameNotFound', 'This is not a valid name in Scenario: %s'
    'Scenario:Wrapper:CannotExogenizeName', 'This name cannot be exogenized in Scenario: %s'
    'Scenario:Wrapper:CannotEndogenizeName', 'This name cannot be endogenized in Scenario: %s'
    'Series:DatesDataDimensionMismatch', 'Number of dates must match number of rows of observations when creating a new time series.'
    'Series:BinopSizeMismatch', 'The size of the resulting Series object must match the size of one of the input Series objects.'
    'Series:InputsRemovedFromCat', 'Inputs other than time series and numeric removed from concatenation.'
    'Series:InvalidSizeColumnNames', 'Size of time series comment must be compatible with the number of time series columns '
    'Series:InvalidValueColumnNames', 'Comments assigned to time series must be text strings '
    'Series:InconsistentSizeVertCat', 'Size of vertically concatenated time series must be consistent in 2nd and higher dimension'
    'Series:CannotVertCatNonSeries', 'Cannot vertically concatenate time series with other types of data. '
    'Series:CannotCatMixedFrequencies', 'Cannot concatenate time series with different date frequencies.'
    'Series:FrequencyMismatch', 'Date frequency or time series frequency mismatch: %s '
    'TimeSubscriptable:FrequencyMismatch', 'Date frequency or time series frequency mismatch: %1 x %s '
    'Series:TimeDimMustBeZero', 'Time dimension must be zero when creating empty time series'
    'Series:CannotConvertIntegerFreq', 'Cannot covert times series from or to INTEGER frequency'
    'Series:CannotConvertWeeklyToDaily', 'Cannot convert time series from WEEKLY to DAILY frequency'
    'Solver:GradientRequestedButNotPrepared', 'Gradient requested but not prepared; use option PrepareGradient=true'
    'Steady:BothUnlogLogminus', 'This name is used in both Unlog= and LogMinus= options: %s '
    'Steady:CannotFix', 'Cannot fix this name: %s '
    'Steady:ExogenousLevelNan', 'This parameter or the level of this exogenized variable is not assigned: %s '
    'Steady:ExogenousGrowthNan', 'The growth rate of this exogenized variable is not assigned: %s '
    'Steady:InvalidLogminus', 'This name cannot be used in LogMinus= option: %s '
    'Steady:InvalidUnlog', 'This name cannot be used in Unlog= option: %s '
    'Steady:StructuralSingularity', 'System of steady equations is structurally singular.'
    'Steady:WrongSignGrowthBounds', 'Invalid lower and/or upper bound for steady-state growth of this variable: %s '
    'Steady:WrongSignLevelBounds', 'Invalid lower and/or upper bound for steady-state level of this variable: %s '
    'Steady:LevelFixedToNan', 'Level of this variable fixed to NaN: %s'
    'Steady:GrowthFixedToNan', 'Growth of this variable fixed to NaN: %s'
    'Steady:EvaluatesToNan', 'This steady equation evaluates to NaN or Inf: %s'
    'SVAR:InvalidSelection', 'This is not a valid %1name in VAR object: %s'
    'SystemPriors:ErrorParsingDefinition', 'Error parsing this definition string: %s '
    'SystemPriors:InvalidColumn', 'This is not a valid column name: %s '
    'SystemPriors:InvalidName', 'This is not a valid parameter or steady-state name: %s '
    'SystemPriors:InvalidPriorFunction', 'This is not a valid system prior function name: %s '
    'SystemPriors:InvalidRow', 'This is not a valid row name: %s '
    'SystemPriors:LowerUpperBound', 'Lower bound must be lower than upper bound.'
    'SystemPriorWrapper:SystemPropertyToSealed', 'Cannot add SystemProperty to a sealed SystemPriorWrapper object'
    'SystemPriorWrapper:SystemPriorToSealed', 'Cannot add SystemPrior to a sealed SystemPriorWrapper object'
    'SystemPriorWrapper:IllegalOutputName', 'SystemProperty output names must be legal variable names'
    'SystemPriorWrapper:NonuniqueOutputName', 'This output name assigned to SystemProperty is not unique: %s'
    'SystemPriorWrapper:NamesExceedMaxNumOutputs', 'Number of SystemProperty names exceeds maximum number of output arguments'
    'TimeSubscriptable:IfElseTest', 'The if test must produce a logical array of the same size as the time series data'
    'TheParser:EmptyEquation', 'This equation is empty and will be removed: %s '
    'TheParser:EmptyLhsOrRhs', 'LHS or RHS of this equation is empty: %s '
    'TheParser:EssentialBlocksMissing', 'Cannot find a nonempty %s block; this is not a valid source file.'
    'TheParser:InvalidBounds', 'This is not a valid lower-upper bounds specification: %s '
    'TheParser:InvalidKeyword', 'This is not a valid keyword: %s '
    'TheParser:InvalidName', 'This is not a valid name: %s '
    'TheParser:InvalidPairingDefinition', 'This is not a valid pairing definition: %s '
    'TheParser:InvalidStdCorrAssigned', 'This is not a valid std_ or corr_ name to assign: %s '
    'TheParser:ReservedPrefixDeclared', 'Cannot declare name starting with a reserved prefix: %s '
    'TheParser:InvalidTimeSubscript', 'Invalid lag or lead: %s '
    'TheParser:MutlipleNames', 'This name is declared multiple times: %s '
    'TheParser:ReservedName', 'This is a reserved name in IRIS and cannot be used as a name in models: %s '
    'TheParser:StdNameWithDoubleUnderscore', 'Names of shocks cannot include double underscores: %s '
    'TimeSeriesBase:IfTestCompliance', 'Test function must return logical index of the same size as the input time series.'
    'VAR:CannotEstimateEmptyVar', 'Cannot estimate VAR object with no variables.'
    'VAR:CannotInfRangeInPanel', 'Cannot use Inf for input range in panel VAR estimation.'
    'VAR:GroupNotInputData', 'This group is missing from input databank: %s '
    'VAR:InvalidParameterType', 'This is not a valid type of VAR parameters: %s'
    'VAR:NonuniqueName', 'This name occurs more than once in VAR object: %s '
    'VAR:CannotHandleUnstable', 'Cannot calculate %1 for unstable parameter variants: %s'
};

end%

