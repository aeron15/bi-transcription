function [best_hits,best_hits_1,best_hits_3,best_hits_dist,ratio_plate]=plot_scatter_positives_graph(plates,test,plates_all)

%PLOT_MATRIX_POSITIVES plots the wells in a 96 well plate where assayed

%PLOT_MATRIX_POSITIVES plots the wells in a 96 well plate where %99 percent
%of the cells in that well are above a threshold
%
%TEST is 0 by default

load('map_plate_96');


if(nargin<2)
    test=0;
end

if(nargin<3)
    plates_all=fieldnames(plates);
else
    plates_all={plates_all};
end


for a=1:numel(plates_all)
    
    strains=fieldnames(plates.(plates_all{a}));
    
    plate=plates_all{a}
    k=1;
    scrsz = get(0,'ScreenSize');
    figure('Position',[100,1000,2000,1300])
    %hold all;
    set(gcf,'color',[1 1 1]);
    
    
    %
    % Determining the baseline parameters in H02
    %
    
    %well_wt=plates.(plate).H02;
    %dsred_wt = filter_dsred_log10(well_wt);
    %fitc_wt=filter_fitc_log10(well_wt);
    
    %
    % Calculate median SSC for the plate to filter data subsequently
    %
    
    ssc_tot=[];
    
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
    
    %
    % Compute median dsred and fitc values for all the plate
    %
    
    dsred_tot=[];
    fitc_tot=[];
    %mid_all=[];
    
    
    if(test)
        for i=1:8
            for j=1:12
                
                %Check if that well was assayed in the experiment.
                
                if(sum(strcmp(Well(i,j),strains))==1)
                    
                    %Extract cell values in matrix
                    
                    well=plates.(plate).(cell2mat(strains(strcmp(Well(i,j),strains))));
                    %[dsred,mid] = filter_dsred_log10(well);
                    dsred = filter_dsred_log10_midssc(well,mid_ssc);
                    %mid_all=[mid_all;mid];
                    fitc = filter_fitc_log10_midssc(well,mid_ssc);
                    
                    dsred_tot=[dsred_tot;dsred];
                    fitc_tot=[fitc_tot;fitc];
                end
            end
        end
        
        
        dsred_median=median(dsred_tot);
        fitc_median=median(fitc_tot);
        
    end
    
    mid_ssc=100601;
    %         dsred_median=2.9170;
    %         fitc_median=2.4472;
    
    %        dsred_median=2.9103;
    %       fitc_median=2.7615;
    %
    
    dsred_median=2.9222;
    fitc_median=2.4472;
    median_fitc_autofluor =2.0925;
    median_dsred_autofluor =2.7771;
    
    for i=1:8
        for j=1:12
            
            
            
            %Check if that well was assayed in the experiment.
            
            if(sum(strcmp(Well(i,j),strains))==1)
                
                %mx(i,j)=1;
                
                %Extract cell values in matrix
                
                well=plates.(plate).(cell2mat(strains(strcmp(Well(i,j),strains))));
                %well=plates.(cell2mat(plate)).(cell2mat(strains(strcmp(Well(i,j),strains))));
                
                %
                dsred = filter_dsred_log10_midssc(well,mid_ssc);
                fitc = filter_fitc_log10_midssc(well,mid_ssc);
                median_dsred_well=median(dsred);
                median_fitc_well=median(fitc);
                
                if(~(numel(dsred)==numel(fitc)))
                    error('dsred and fitc should have the same dimensions');
                end
                %median_dsred_well=median_dsred_well-median_fitc_autofluor;
                %median_fitc_well=median_fitc_well-median_fitc_autofluor;
                
                ratio=median_fitc_well/median_dsred_well;
                ratio_plate.(strcat(plate,'_',cell2mat(strains(strcmp(Well(i,j),strains)))))=ratio;
                
                
                
                if(numel(dsred)<100)
                    
                    subplot(8,12,k);
                    text(3.7,3.3,[Well(i,j)],'HorizontalAlignment','center','BackgroundColor',[1 0 0]);
                    set(gca,'LineWidth',1,'FontSize',7);
                    hold all;
                    xlim([2 4])
                    ylim([1.5 3.5])
                    %
                    
                else
                    
                    if(test)
                        
                        subplot(8,12,k);
                        
                        
                        %Random sampling for fast plotting
                        
                        %index_sample=randsample((1:numel(dsred)),750);
                        %dsred_plot=dsred(index_sample);
                        
                        %fitc_plot=fitc(index_sample);
                        
                        
                        %
                        % Test and color according to chosen criterion
                        %
                        %
                        
                        [quadrant, fract, mark_col]=test_diff_dsred_fitc(dsred_median,fitc_median,dsred,fitc);
                        
                        %Calculate distance to the line defined by
                        %dsred_median and fitc_median
                        
                        dist_score=compute_dist(dsred_median,fitc_median,dsred,fitc);
                        
                        %Save all cells in quadrant 1, 2, 3 and 4
                        rank_strains.(strcat(plate,'_quad',num2str(quadrant),'_',cell2mat(strains(strcmp(Well(i,j),strains)))))=fract;
                        rank_strains_dist_score.(strcat(plate,'_quad',num2str(quadrant),'_',cell2mat(strains(strcmp(Well(i,j),strains)))))=dist_score;
                        
                        %Save the distance scores
                        %                         if(quadrant==1|quadrant==3)
                        %                             rank_strains.(strcat(plate,'_quad',num2str(quadrant),'_',cell2mat(strains(strcmp(Well(i,j),strains)))))=fract;
                        %                             rank_strains_dist_score.(strcat(plate,'_quad',num2str(quadrant),'_',cell2mat(strains(strcmp(Well(i,j),strains)))))=dist_score;
                        %                         end
                        %
                        %Save cells only in quadrant 1 and 3
                        if(quadrant==1)
                            
                            rank_strains_1.(strcat(plate,'_quad',num2str(quadrant),'_',cell2mat(strains(strcmp(Well(i,j),strains)))))=fract;
                            %rank_strains.(strcat(plate,'_quad',num2str(quad),'_',cell2mat(strains(strcmp(Well(i,j),strains)))))=fract;
                        end
                        
                        if(quadrant==3)
                            
                            rank_strains_3.(strcat(plate,'_quad',num2str(quadrant),'_',cell2mat(strains(strcmp(Well(i,j),strains)))))=fract;
                            %rank_strains.(strcat(plate,'_quad',num2str(quad),'_',cell2mat(strains(strcmp(Well(i,j),strains)))))=fract;
                        end
                        
                        
                        %
                        %Plot data
                        %
                        
                        plot(dsred,fitc,'.','markerfacecolor',mark_col,'MarkerEdgeColor',mark_col,'MarkerSize',4);
                        %median_dsred_well
                        %bar(median_dsred_well,'r');set(gca,'XLim',[0 1.6]);colormap summer;
                        %bar([ratio 1-ratio;0.8 0.2],'stack');set(gca,'XLim',[0 1.6]);colormap summer;
                        set(gca,'LineWidth',1,'FontSize',7);
                        
                        %
                        % Display distance score
                        %
                        dist_score_plot=round(dist_score / 0.0001) * 0.0001;
                        ratio=round(ratio/ 0.0001) * 0.0001;
                        
                        %text(3.5,3.2,mat2str(dist_score_plot),'HorizontalA
                        %lignment','center','BackgroundColor',[1 1 1]);\
                        %xlabel([Well(i,j)]);
                        %ylabel(mat2str(ratio));
                        %text(2.5,3.2,[Well(i,j)],'HorizontalAlignment','center','BackgroundColor',[1 1 1]);
                        %text(3.5,3.2,mat2str(ratio),'HorizontalAlignment','center','BackgroundColor',[1 1 1]);
                        hold all;
                        xlabel('mCherry','fontsize',8);
                        ylabel('YFP','fontsize',8)
                        
                        xlim([2 4])
                        ylim([1.5 3.5])
                        
                        %FITC mCherry
                        
                        hline(fitc_median,'r');
                        vline(dsred_median,'r');
                        
                        %Draw line that goes from the point (background
                        %autofluorescence mCherry, background
                        %autofluorescence YFP) to the point (median mCherry
                        %,median YFP)
                        
                        x2=5;
                        y2=(fitc_median/dsred_median)*x2;
                        
                        %line([0 x2],[0 y2],'Color','r')
                        
                        hold off;
                    end
                end
                
                
            else
                
                subplot(8,12,k);
                text(3.7,3.3,[Well(i,j)],'HorizontalAlignment','center','BackgroundColor',[1 1 1]);
                set(gca,'LineWidth',1,'FontSize',7);
                xlim([2 4])
                ylim([1.5 3.5])
            end
            
            k=k+1;
        end
    end
    %hold off;
    
    mtit(strrep(plate,'_','\_'),'fontsize',14,'color',[1 0 0],'xoff',-.1,'yoff',.025);
    
    %
    %Best hits per plate
    %
    %Check existence of structure
    
    
    if(exist('rank_strains_1'))
        
        if(numel(fieldnames(rank_strains_1))>5)
            best_hits_1.(plate)=filter_best_hits(rank_strains_1,5);
        else
            best_hits_1.(plate)=filter_best_hits(rank_strains_1,numel(fieldnames(rank_strains_1)));
        end
        %best_hits_1=get_plate_values(best_hits_1);
        %clear('rank_strains_1');
        
    else
        
        display('Rank_strains_1 has no entries');
        
        if(a==1)
            best_hits_1=0;
        end
    end
    
    
    if(exist('rank_strains_3'))
        
        if(numel(fieldnames(rank_strains_3))>5)
            best_hits_3.(plate)=filter_best_hits(rank_strains_3,5);
        else
            best_hits_3.(plate)=filter_best_hits(rank_strains_3,numel(fieldnames(rank_strains_3)));
        end
        
        %best_hits_3=get_plate_values(best_hits_3);
        
    else
        
        display('Rank_strains_3 has no entries');
        
        if(a==1)
            best_hits_3.(plate)=0;
        end
    end
    
    %rank_strains_1 and 3 are empty structure
    
    clear('rank_strains_1');
    clear('rank_strains_3');
    
end

best_hits=filter_best_hits(rank_strains);

best_hits_dist=filter_best_hits(rank_strains_dist_score);

%export_csv(best_hits,'Top_all_quads');
%export_csv(best_hits_dist,'Top_all_quads_dist');


%export_csv(rank_strains,'Top_all_quads_not_ordered');
%export_csv(rank_strains_dist_score,'Top_all_quads_dist_not_ordered');

%best_hits_1_trimmed=get_plate_values(best_hits_1);
%best_hits_3_trimmed=get_plate_values(best_hits_3);

%cell2csv('Top_5_quad_1',best_hits_1_trimmed,'\t');
%cell2csv('Top_5_quad_3',best_hits_3_trimmed,'\t');

end
