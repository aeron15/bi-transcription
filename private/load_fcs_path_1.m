function FACS_data=load_fcs_path(FoldersToAnalyse,typeplate)
%LOAD_FCS_PATH loads all the paths to the fcs files in the folders of an experiment


switch typeplate
    
    case 96
        
        load('map_plate_96');
        
    case 384
        
        load('map_plate_384')
        
    otherwise
        
        display('Invalid value for number of wells')
        
end


for (a=1:numel(FoldersToAnalyse))
    
    Message=strcat({'Loading folder '},{FoldersToAnalyse{a}});
    
    display(Message)
    
    %Look in the folder data/ for the path to the folder
    
    pathtofolder=strcat('data/',FoldersToAnalyse{a});
    
    Files=map_fcs_files(pathtofolder,Well);
    
    %Read files with information of the strains, meida, time and plates used in the experiment
    
    StrainsFile=strcat(pathtofolder,'/Strains.csv');
    MediaFile=strcat(pathtofolder,'/Media.csv');
    TimeFile=strcat(pathtofolder,'/Time.csv');
    
    %Read files
    
    Strains=read_csv(StrainsFile);
    Media=read_csv(MediaFile);
    Time=read_csv(TimeFile);
    
    %The real time could be extracted from the header of the fcs file or
    %provided by the user
    
    %RealTime=load('RealTime.csv');
    
    
    for k=1:8
        
        for l=1:12
            
            %Do not load 'Empty' strains
            if (~(strcmp('Empty',char(Strains(k,l)))))
                
                %Load data into the struture
                
                variable=strcat('FACS_data.',(Strains{k,l}),'.',(Media{k,l}),'.',(Time{k,l}),'.',(Well{k,l}));
                
                %Check if there is a replicate in the same position in a
                %different plate
                
                %If a==1 then the first plate is being read and no
                %replicates in the same position and plates are possible
                
                if(a==1)
                    
                    FACS_data.(Strains{k,l}).(Media{k,l}).(Time{k,l}).(Well{k,l})=strcat(pathtofolder,'/',Files.(Well{k,l}));
                    
                    ReplicateCounter=1;
                    
                else
                    
                    variable=FACS_data.(Strains{k,l}).(Media{k,l}).(Time{k,l}).(Well{k,l});
                    
                    if exist(variable)
                        
                        display('new replicate')
                        
                        ReplicateCounter=ReplicateCounter+1;
                        
                        WellReplicate=strcat(Well{k,l},'_',num2str(ReplicateCounter));
                        
                        %Load data into the struture
                        
                        FACS_data.(Strains{k,l}).(Media{k,l}).(Time{k,l}).(WellReplicate)=strcat(pathtofolder,'/',Files.(Well{k,l}));
                        
                        
                    end
                    
                end
                
                
                
            end
        end
    end
    
end

end

