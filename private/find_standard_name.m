function standard_name=find_standard_name(names_structure,plate_number,row,column)

for i=1:size(names_structure,1)
    
    %check plate number
    if (strcmp(names_structure{i,5},plate_number))
        
        %check row
        
        if (strcmp(names_structure{i,6},row))
            
            %check column
            if (strcmp(names_structure{i,7},column))
                
                %display('hit found');
                
                standard_name=names_structure{i,2};
         
            end
            
        end
    end
end

if(~(exist('standard_name')))
    
    standard_name='NA';
end


end