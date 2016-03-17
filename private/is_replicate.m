function [test,ReplicateCounter]=is_replicate(Structure,strain,medium,time,well)
%IS_REPLICATE verifies if a a Structure (FACS_data) contains an exact
%replicate on a different well (same Strains, Media, Time and position in
%the plate. Returns 1 if the field exists and 0 if not

%Check if the strain is one of the fields
if isfield(Structure,strain)
    
    %Check if medium is the same
    if isfield(Structure.(strain),medium)
        
        %Check if time is the same
        if isfield(Structure.(strain).(medium),time)
            
            %Check if well is the same
            
            ReplicateWells=fieldnames(Structure.(strain).(medium).(time));
            
            Matches=regexp(ReplicateWells,well);
            
            %if matches are found list how many based on this number return
            %the Replicate Counter
            
            ReplicateCounter=numel(cell2mat(Matches))+1;
            
            test=1;
            
        else
            
            test=0;
            ReplicateCounter=0;
            
        end
        
    else
        
        test=0;
        ReplicateCounter=0;
        
    end
    
else
    
    test=0;
    ReplicateCounter=0;
    
    
end

end