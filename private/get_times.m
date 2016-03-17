function names = get_times(plates)
%GET_TIMES returns a cell array of all TIME fields in PLATES
%
% Ensure PLATES is always a cell array
if (~iscell(plates))
    plates = {plates};
end
names = {};
% Search list for unique times
for a=1:numel(plates)
    plate_strains = fieldnames(plates{a});
    for b=1:numel(plate_strains)
        plate_media = fieldnames(plates{a}.(plate_strains{b}));
        for c=1:numel(plate_media)
            plate_times = fieldnames(plates{a}.(plate_strains{b}).(plate_media{c}));
            for d=1:numel(plate_times)
                if(sum(strcmp(plate_times(d),names))==0)
                names = [names; plate_times(d)];
            end
        end
    end
end
% Alphabetize
names = sortcell(names);
end