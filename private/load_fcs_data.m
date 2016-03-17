
function FACS_data=load_fcs_data(FACS_data_paths,Plates)

%LOAD_FCS_DATA populates the FACS_Data structure with values read from fcs
%files

Structure=FACS_data_paths;

for PlateIndex=1:length(Plates)
    
    Strains=fieldnames(Structure.(Plates{PlateIndex}));
    
    for StrainIndex=1:length(Strains)
        
        Wells=fieldnames(Structure.(Plates{PlateIndex}).(Strains{StrainIndex}));
        
        for WellIndex=1:length(Wells)
            
            FileToRead=Structure.(Plates{PlateIndex}).(Strains{StrainIndex}).(Wells{WellIndex});
            
            %[DATA,param,HEADER]=fcsread(FileToRead);
            [DATA,param,HEADER]=read_fcs_light(FileToRead);
            
            runtime=HEADER(strcmp(HEADER(:,1),'$BTIM'),2);
            
            date=HEADER(strcmp(HEADER(:,1),'$DATE'),2);
            
            plate=HEADER(strcmp(HEADER(:,1),'PLATE NAME'),2);
            
            well=HEADER(strcmp(HEADER(:,1),'WELL ID'),2);
            
            %Find which parameters are in which rows
            if ~exist('ParameterNames')
                
                ParameterNames=extract_parameter_names(param);
                
                %Get Rid of weird parameters
                
                ParameterNames=eliminate_weird_characters(ParameterNames);
            end
            
            
            for i=1:length(ParameterNames)
                
                %Populate structure
                
                FACS_data.(Plates{PlateIndex}).(Strains{StrainIndex}).(Wells{WellIndex}).(ParameterNames{i})=DATA(:,i);
                
            end
            
            %Add Time and Data after cyclin all other
            %parameters
            
            
            FACS_data.(Plates{PlateIndex}).(Strains{StrainIndex}).(Wells{WellIndex}).('RunTime')=runtime;
            FACS_data.(Plates{PlateIndex}).(Strains{StrainIndex}).(Wells{WellIndex}).('Date')=date;
            FACS_data.(Plates{PlateIndex}).(Strains{StrainIndex}).(Wells{WellIndex}).('Plate_Name')=plate;
            FACS_data.(Plates{PlateIndex}).(Strains{StrainIndex}).(Wells{WellIndex}).('Well_ID')=well;
            
        end
        
    end
    
end

end