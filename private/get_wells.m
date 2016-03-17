function wells = get_wells(plates, strain, media, time)
%GET_WELLS returns a cell array of strains in PLATES that match the
%  provided criteria of strings STRAIN, MEDIA, and TIME. These criteria may
%  also be cell arrays of strings, in which case all matching combinations
%  will be returned.
%
% Ensure PLATES is always a cell array
if (~iscell(plates))
    plates = {plates};
end
wells = {};
for a=1:numel(plates)
    % Match Strains
    plate_strains = fieldnames(plates{a});
    for b=1:numel(plate_strains)
        if(sum(strcmp(plate_strains(b),strain))>0)
            
            % Match Media
            plate_media = fieldnames(plates{a}.(plate_strains{b}));
            for c=1:numel(plate_media)
                if(sum(strcmp(plate_media(c),media))>0)
                    
                    % Match Times
                    plate_times = fieldnames(plates{a}.(plate_strains{b}).(plate_media{c}));
                    for d=1:numel(plate_times)
                        if(sum(strcmp(plate_times(d),time))>0)
                            
                            % Group Wells
                            plate_wells = fieldnames(plates{a}.(plate_strains{b}).(plate_media{c}).(plate_times{d}));
                            for e = 1:numel(plate_wells)
                                if(isstruct(plates{a}.(plate_strains{b}).(plate_media{c}).(plate_times{d}).(plate_wells{e})))
                                    wells = [wells; ...
                                        plates{a}.(plate_strains{b}).(plate_media{c}).(plate_times{d}).(plate_wells{e})];
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
end