function names = get_strains(plates)
%GET_STRAINS returns a cell array of all strain fields in PLATES
%
% Ensure PLATES is always a cell array
if (~iscell(plates))
    plates = {plates};
end
names = {};
% Search list for unique strains
for i=1:numel(plates)
    plate_strains = fieldnames(plates{i});
    for j=1:numel(plate_strains)
        if(sum(strcmp(plate_strains(j),names))==0)
            names = [names; plate_strains(j)];
        end
    end
end
% Alphabetize
names = sortcell(names);
end