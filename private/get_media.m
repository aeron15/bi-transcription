function names = get_media(plates)
%GET_MEDIA returns a cell array of all media fields in PLATES
%
% Ensure PLATES is always a cell array
if (~iscell(plates))
    plates = {plates};
end
names = {};
% Search list for unique media
for a=1:numel(plates)
    plate_strains = fieldnames(plates{a});
    for b=1:numel(plate_strains)
        plate_media = fieldnames(plates{a}.(plate_strains{b}));
        for c=1:numel(plate_media)
            if(sum(strcmp(plate_media(c),names))==0)
            names = [names; plate_media(c)];
        end
    end
end
% Alphabetize
names = sortcell(names);
end