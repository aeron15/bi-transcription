function ParameterNames=extract_parameter_names(param)
%This function goes through the HEADER file extracted from a FCS file and
%pulls out the parameters
for i=1:length(param)
        ParameterNames{i}=param(i).Name;
end