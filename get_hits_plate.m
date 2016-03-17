function [rank_strains,rank_strains_dist,top_hits_quad1,top_hits_quad4]=get_hits_plate(plates,plate,test)

%GET_HITS_PLATE returns the best hits in the plate according to the
%specified criterion

counts=[];

if(nargin<3)
    test=1;
end

load('map_plate_96');

k=1;

%     scrsz = get(0,'ScreenSize');
%     figure('Position',[100,1000,2000,1300])
%     %hold all;
%     set(gcf,'color',[1 1 1]);

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
%
% Compute median dsred and fitc values for all the plate also count the
% number of cells sampled per well
%

dsred_tot=[];
fitc_tot=[];
%cells_per_well_tot=[];

if(test)
    for i=1:8
        for j=1:12
            
            %Check if that well was assayed in the experiment.
            
            if(sum(strcmp(Well(i,j),strains))==1)
                
                %Extract cell values in matrix
                
                well=plates.(plate).(cell2mat(strains(strcmp(Well(i,j),strains))));
                dsred = filter_dsred_log10_midssc(well,mid_ssc);
                fitc = filter_fitc_log10_midssc(well,mid_ssc);
                
                dsred_tot=[dsred_tot;dsred];
                fitc_tot=[fitc_tot;fitc];
                %                 if (numel(dsred)==numel(fitc))
                %                 cells_per_well_tot=[cells_per_well_tot;numel(dsred)];
                %                 else
                %                     display('Alerta mushu mushu');
                %                 end
            end
        end
    end
    
    
    dsred_median=median(dsred_tot);
    fitc_median=median(fitc_tot);
    
end

%%
%
% Compute best hits per plate
%

for i=1:8
    for j=1:12
        
        flag=1;
        
        %Check if that well was assayed in the experiment.
        
        if(sum(strcmp(Well(i,j),strains))==1)
            
            %Extract cell values in matrix
            
            well=plates.(plate).(cell2mat(strains(strcmp(Well(i,j),strains))));
            %well=plates.(cell2mat(plate)).(cell2mat(strains(strcmp(Well(i,j),strains))));
            
            %
            dsred = filter_dsred_log10_midssc(well,mid_ssc);
            fitc = filter_fitc_log10_midssc(well,mid_ssc);
            
            if(~(numel(dsred)==numel(fitc)))
                
                flag=0;
                display('-->Dimension mismatch!');
                cell2mat(strains(strcmp(Well(i,j),strains)))
                
            end
            
            if(numel(dsred)<100|flag==0)
                
                %                     subplot(8,12,k);
                %                     text(3.5,3,[Well(i,j)],'HorizontalAlignment','center','BackgroundColor',[1 1 1]);
                %                     set(gca,'LineWidth',1,'FontSize',7);
                %                     hold all;
                %                     xlim([2 4])
                %                     ylim([1.5 3])
                %                     %
                
            else
                
                if(test)
                    
                    %                         subplot(8,12,k);
                    
                    
                    %Random sampling for fast plotting
                    
                    %                         index_sample=randsample((1:numel(dsred)),20);
                    %                         dsred_plot=dsred(index_sample);
                    %
                    %                         fitc_plot=fitc(index_sample);
                    %
                    %scatter(dsred_plot,fitc_plot,'+');
                    
                    %
                    % Test and color according to chosen criterion
                    %
                    %
                    
                    
                    
                    [quad, fract, mark_col,count_quad]=test_diff_dsred_fitc(dsred_median,fitc_median,dsred,fitc);
                    
                    %count_quad
                    
                    counts=[counts;count_quad];
                    
                    %Calculate distance to the line defined by
                    %dsred_median and fitc_median
                    
                    dist_score=compute_dist(dsred_median,fitc_median,dsred,fitc);
                    
                    %Save all cells in quadrants 1, 2, 3 and 4
                    rank_strains.(strcat(plate,'_quad',num2str(quad),'_',cell2mat(strains(strcmp(Well(i,j),strains)))))=fract;
                    rank_strains_dist.(strcat(plate,'_quad',num2str(quad),'_',cell2mat(strains(strcmp(Well(i,j),strains)))))=dist_score;
                    
                    %Save the distance scores for quadrants 1 and 3
                    %                         if(quad==1|quad==3)
                    %                             rank_strains.(strcat(plate,'_quad',num2str(quad),'_',cell2mat(strains(strcmp(Well(i,j),strains)))))=fract;
                    %                             rank_strains_dist.(strcat(plate,'_quad',num2str(quad),'_',cell2mat(strains(strcmp(Well(i,j),strains)))))=dist_score;
                    %                         end
                    %
                    
                    %Save cells only in quadrant 1 and 3
                    if(quad==1&count_quad>=300)
                        
                        rank_strains_1.(strcat(plate,'_quad',num2str(quad),'_',cell2mat(strains(strcmp(Well(i,j),strains)))))=fract;
                        %rank_strains.(strcat(plate,'_quad',num2str(quad),'_',cell2mat(strains(strcmp(Well(i,j),strains)))))=fract;
                    end
                    
                    if(quad==4&count_quad>=300)
                        
                        rank_strains_4.(strcat(plate,'_quad',num2str(quad),'_',cell2mat(strains(strcmp(Well(i,j),strains)))))=fract;
                        %rank_strains.(strcat(plate,'_quad',num2str(quad),'_',cell2mat(strains(strcmp(Well(i,j),strains)))))=fract;
                    end
                    
                    
                    %
                    %Plot data
                    %
                    
                    %                         plot(dsred,fitc,'.','markerfacecolor',mark_col,'MarkerEdgeColor',mark_col,'MarkerSize',4);
                    %                         set(gca,'LineWidth',1,'FontSize',7);
                    %
                    %
                    % Calculate correlation between variables
                    %
                    %                         dist_score_plot=round(dist_score / 0.0001) * 0.0001;
                    %                         text(3.5,3.2,mat2str(dist_score_plot),'HorizontalAlignment','center','BackgroundColor',[1 1 1]);
                    %                         %hold all;
                    %                         xlabel('mCherry','fontsize',8);
                    %                         ylabel('YFP','fontsize',8)
                    %                         xlim([2 4]);
                    %                         ylim([1.5 3]);
                    %
                    %                         hline(fitc_median,'r');
                    %                         vline(dsred_median,'r');
                    %
                    %                         x2=5;
                    %                         y2=(fitc_median/dsred_median)*x2;
                    %
                    %                         line([0 x2],[0 y2],'Color','r')
                    %
                    %hold off;
                end
            end
            
            
        else
            display('Well not found in assay')
            %                 subplot(8,12,k);
            %                 text(5,4,[Well(i,j)],'HorizontalAlignment','center','BackgroundColor',[1 1 1]);
            %                 set(gca,'LineWidth',1,'FontSize',7);
            %                 xlim([2 4]);
            %                 ylim([1.5 3]);
            %
        end
        
        k=k+1;
    end
end

%hold off;

%mtit(strrep(plate,'_','\_'),'fontsize',14,'color',[1 0 0],'xoff',-.1,'yoff',.025);

%Best hits per plate

%Check existence of structure


if(exist('rank_strains_1'))
    
    if(numel(fieldnames(rank_strains_1))>5)
        %top_hits_quad1.(plate)=filter_top_hits(rank_strains_1,5);
        top_hits_quad1=filter_top_hits(rank_strains_1,5);
        %top_hits_quad1=get_plate_values_2(top_hits_quad1);
        
    else
        top_hits_quad1=filter_top_hits(rank_strains_1,numel(fieldnames(rank_strains_1)));
        %top_hits_quad1=get_plate_values_2(top_hits_quad1);
        
    end
else
    
    display('Rank_strains_1 has no entries');
    top_hits_quad1=-1;
end


if(exist('rank_strains_4'))
    
    if(numel(fieldnames(rank_strains_4))>5)
        top_hits_quad4=filter_top_hits(rank_strains_4,5);
        %top_hits_quad4=get_plate_values_2(top_hits_quad4);
        
        
    else
        top_hits_quad4=filter_top_hits(rank_strains_4,numel(fieldnames(rank_strains_4)));
        %top_hits_quad4=get_plate_values_2(top_hits_quad4);
        
    end
    
else
    
    display('rank_strains_4 has no entries');
    top_hits_quad4=-1;
    
end

%rank_strains=get_plate_values_2(rank_strains);
%rank_strains_dist=get_plate_values_2(rank_strains_dist);

end