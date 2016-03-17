
%normalize per plate look for the lowest yfp and mcherry value in a plate
%get plate cell array (just like in plot_plate_colors) and then find lowest
%yfp and lowest mcherry substract to each measurement and plot result

%return cell array with normalized data per plate
function plot_plates_screen(median_fluorescence)

%extract plate number and add it to the last column of the
%median_fluorescence array

coldim=size(median_fluorescence,2)+1;

for i=1:size(median_fluorescence,1)
    
    splitstr=regexp(median_fluorescence{i,1},'\.','split');
    
    plate_number=splitstr{3};
    plate_number=str2num(plate_number);
    
    median_fluorescence(i,coldim)=num2cell(plate_number);
    
end

normalized_median_fluorescence={};

platenames=cell2mat(median_fluorescence(:,coldim));

for i=unique(platenames)'
    
    x=cell2mat(median_fluorescence(platenames==i,2));
    y=cell2mat(median_fluorescence(platenames==i,3));
    
    
    scatter(cell2mat(median_fluorescence(platenames==i,2)),cell2mat(median_fluorescence(platenames==i,3)))
    set(gcf,'color',[1 1 1]);
    title('median yfp versus and median mcherry in every well');
    xlabel('mcherry','fontsize',10);
    ylabel('yfp','fontsize',10);
    gname(median_fluorescence(platenames==i,1));
    %pause;
    
end



end