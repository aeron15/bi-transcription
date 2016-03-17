function ParameterNames=eliminate_weird_characters(ParameterNames)
for Count=1:length(ParameterNames)
    ParameterNames{Count}=regexprep(ParameterNames{Count},'\W','_');
end