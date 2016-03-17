function extracted_strains=extract_strains(quad,normalized_fluorescence)

 extracted_strains={};
 
for strain_indx=1:numel(quad)
    
    strain_name=quad{strain_indx};
    
    k=1;
    
    [matchstr splitstr] = regexp(strain_name, '_', 'match','split');
    
    
    plate_number=splitstr{1};
    well_name=splitstr{2};
    row=well_name(1);
    
    
    %Make sure that every element in column seven has at least a size 3
    
    
    for i=1:numel(normalized_fluorescence(:,7))
        
        well_name1=normalized_fluorescence{i,7};
        
        if(numel(well_name1)==2)
            
            well_name2=[well_name1(1),'0',well_name1(2)];
            normalized_fluorescence{i,7}=well_name2;
        end
        
        
    end
    
    %strain_name is the queried strain
    
    [matchstr splitstr] = regexp(strain_name, '_', 'match','split');
    
    plate_number=splitstr{1};
    well_name=splitstr{2};
    
    if(numel(well_name)==2)
        
        row=well_name(1);
        column=well_name(2);
        column=num2str(column);
        well_name=[well_name(1),'0',well_name(2)];
        
        extracted_strains=[extracted_strains ; normalized_fluorescence((strcmp(normalized_fluorescence(:,7),well_name)+strcmp(normalized_fluorescence(:,8),plate_number)==2),:)];
        %Localize strain
        display('hola')
        %extracted_strains{k,:}=
        
    else
        
        row=well_name(1);
        column=well_name(2:3);
        
        column=num2str(column);
        extracted_strains=[extracted_strains ; normalized_fluorescence((strcmp(normalized_fluorescence(:,7),well_name)+strcmp(normalized_fluorescence(:,8),plate_number)==2),:)];
        
    end
    
end

end