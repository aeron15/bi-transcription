function names = get_wells_names(plates,plate)
%GET_WELLS_MEDIA returns a cell array of all the well positions assayed in
%the experiment
% Ensure PLATES is always a cell array
if (~iscell(plates))
    plates = {plates};
end
names = {};
name_strains={};
% Search list for unique media
for a=1:numel(plates)
    
    %Plate names
    plate_strains = {plate};
    for b=1:numel(plate_strains)
        %Plate strains
        plate_media = fieldnames(plates{a}.(plate_strains{b}));
        for c=1:numel(plate_media)
            
            Wells=fieldnames(plates{a}.(plate_strains{b}).(plate_media{c}));
            
            for WellIndex=1:numel(Wells)
            
            well_name=plates{a}.(plate_strains{b}).(plate_media{c}).(Wells{WellIndex}).Well_ID;
                                    
            names = [names; well_name];
            name_strains=[name_strains;plate_media{c}];
            
            end
        end
    end
    
    names=[names name_strains];
    
end