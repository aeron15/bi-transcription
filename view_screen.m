function Output=view_screen(median_fluorescence)

%VIEW_SCREEN displays the scatter plot median mChery vs median YFP for
%every plate in the data set derived from median_fluorescence
%
%MEDIAN_FLUORESCENCE is a cell array with 5 columns, the first column
%contains the plate name, the second column the mCherry (DsRed) median
%value, the third column YFP (FITC).the fourth contains the number of cells
%assayed in that well and the fifth is the plate 

figure;
Output={};
PlateNames=cell2mat(median_fluorescence(:,5));
for i=unique(PlateNames)'
    
scatter(cell2mat(median_fluorescence(PlateNames==i,2)),cell2mat(median_fluorescence(PlateNames==i,3)))                      
%set_bg_white;
title('Median YFP versus and median mCherry in every well');
xlabel('mCherry','fontsize',10);
ylabel('YFP','fontsize',10);

h=gname(median_fluorescence(PlateNames==i,1));


Output=[Output;get(h,'String')];

OutputFileName= strcat('Output_',mat2str(i));

save(OutputFileName,'Output');

end