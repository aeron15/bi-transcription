
function median_fluorescence=compute_statistics_screen_2(plates,plot_on,plates_all)

%COMPUTE_STATISTICS computes stats for all the plates in a screen. Mainly
%the median size and granularity of cells per well in all the screen and
%the median level of YFP and mCherry per well in every plate (these are
%outliers)
%
%MEDIAN_FLUORESCENCE has mCherry values in column 2 and YFP in column 3
%
%PLOT_ON if 1 then there are 4 columns in the return cell array
%

load('map_plate_96');

if(nargin<2)
    plot_on=0;
    
%     if(plot_on==1)
%         plot_on==1;
%     end

end

if(nargin<3)
    plates_all=fieldnames(plates);
else
    plates_all={plates_all};
end


%Number of cells sampled in the screen

strains=fieldnames(plates.(plates_all{1}));

k=1;


for a=1:numel(plates_all)
    
    plate=plates_all{a};
    
    %%
    %
    % Calculate median SSC for the plate to filter data subsequently
    %
    
    ssc_tot=[];
    
    strains=fieldnames(plates.(plate));
    
    for i=1:8
        for j=1:12
            
            %Check if that well was assayed in the experiment.
            
            if(sum(strcmp(Well(i,j),strains))==1)
                
                %Extract cell values in matrix
                
                well=plates.(plate).(cell2mat(strains(strcmp(Well(i,j),strains))));
                
                
                ssc_well=well.SSC_H;
                
                ssc_tot=[ssc_tot;ssc_well];
                
                
            end
            
        end
    end
    
    mid_ssc=median(ssc_tot);
    
    
    %%
    % Compute median dsred and fitc values for all the plate also count the
    % number of cells sampled per well
    %
    
    
    for i=1:8
        for j=1:12
            
            %Check if that well was assayed in the experiment.
            
            if(sum(strcmp(Well(i,j),strains))==1)
                
                %Extract cell values in matrix
                
                well=plates.(plate).(cell2mat(strains(strcmp(Well(i,j),strains))));
                dsred = filter_dsred_log10_midssc(well,mid_ssc);
                fitc = filter_fitc_log10_midssc(well,mid_ssc);
                
                dsred_median=median(dsred);
                fitc_median=median(fitc);
                
                switch plot_on
                    
                    case 0
                        
                        well_name=strcat(plate,'_',cell2mat(strains(strcmp(Well(i,j),strains))));
                        
                        well_name=regexprep(well_name,'_','.');
                        median_fluorescence{k,1}=well_name;
                        %median_fluorescence{k,1}=cell2mat(strains(strcmp(Well(i,j),strains)));
                        median_fluorescence{k,2}=dsred_median;
                        median_fluorescence{k,3}=fitc_median;
                        median_fluorescence{k,4}=numel(dsred);
                        %display(strcat(plate,'_',cell2mat(strains(strcmp(Well(i,j),strains))));
                        
                    case 1
                        median_fluorescence{k,1}=plate;
                        median_fluorescence{k,2}=cell2mat(strains(strcmp(Well(i,j),strains)));
                        median_fluorescence{k,3}=dsred_median;
                        median_fluorescence{k,4}=fitc_median;
                        median_fluorescence{k,5}=numel(dsred);
                        %display(strcat(plate,'_',cell2mat(strains(strcmp(Well(i,j),strains))));
                end
                k=k+1;
                
            end
        end
    end
    
    
end

%scatter(cell2mat(median_fluorescence(:,2)),cell2mat(median_fluorescence(:,3)));
%scatterhist(cell2mat(median_fluorescence(:,2)),cell2mat(median_fluorescence(:,3)));
%set_bg_white;
%     title('Median YFP versus and median mCherry in every well');
%     xlabel('mCherry','fontsize',10);
%     ylabel('YFP','fontsize',10);
%     gname(median_fluorescence(:,1));


end
