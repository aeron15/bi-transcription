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
    
    Plate=strcat('Plate_',FoldersToAnalyse{a});
    Plate=regexprep(Plate,'-','_');
    
    display(Message)
    
    %Look in the folder data/ for the path to the folder
    
    pathtofolder=strcat('data/',FoldersToAnalyse{a});
    
    Files=map_fcs_files(pathtofolder,Well);
    
    %Read files with information of the strains, meida, time and plates used in the experiment
    
    StrainsFile=strcat(pathtofolder,'/Strains.csv');
    
    %Read files
    
    Strains=read_csv(StrainsFile);
    %Media=read_csv(MediaFile);
    %Time=read_csv(TimeFile);
    
    %The real time could be extracted from the header of the fcs file or
    %provided by the user
    
    %RealTime=load('RealTime.csv');
    
    
    for k=1:8
        
        for l=1:12
            
            %Do not load 'Empty' strains
            if (~(strcmp('Empty',char(Strains(k,l)))))
                
                  %Eliminate blank spaces and dots
                    
                    strain_name=Strains{k,l};
                    strain_name=regexprep(Strains{k,l},'\.','_');
                    strain_name(strain_name==' ') = '';
                    %strain_name=regexprep(Strains{k,l},'\.','_');
                    
                    
                    
                    %Find strain names that start with a number and
                    %concatenate the word "Strain" if it does
                    
                    %a=regexp(strain_name,'^\d','emptymatch');
                    a=regexp(strain_name,'^\d');
                    
                    if(~(isempty(a)))
                       
                        strain_name=strcat('Strain_',strain_name);
                        
                    end
                                        
                    FACS_data.(Plate).(strain_name).(Well{k,l})=strcat(pathtofolder,'/',Files.(Well{k,l}));
                
            end
        end
    end
    
end

end

