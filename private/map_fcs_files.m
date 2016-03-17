function Files=map_fcs_files(path,Well)

%MAP_FCS_FILES maps fcs files into a matlab structure wtih 96 well plates


%Extract all fcs files in the path

fcs_files_in_path=strcat(path,'/*.fcs');

%Files=dir(fcs_files_in_path);

FCS_files=dir(fcs_files_in_path);

%Loop through all the files


for i=1:numel(FCS_files)
    
    file_name=(FCS_files(i).name);
    
    file_to_read=strcat(path,'/',FCS_files(i).name);
    
    [data,param,header]=read_head_fcs(file_to_read);
    
    
    for i=1:8
        for j=1:12
            
            %display(Well(i,j))
            
            if  strcmp(header(strcmp(header,'WELL ID'),2),Well(i,j))
                
                Files.(header{strcmp(header,'WELL ID'),2})=file_name;
                
            end
            
        end
        
    end
    
end

end