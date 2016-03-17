%Analysis rescreens 2767

median_fluorescence((cell2mat(median_fluorescence(:,4))<=1000),:)=[];
median_fluorescence_161111((cell2mat(median_fluorescence_161111(:,4))<=1000),:)=[];
median_fluorescence_2767_0311((cell2mat(median_fluorescence_2767_0311(:,4))<=1000),:)=[];
median_fluorescence_2767_20111103((cell2mat(median_fluorescence_2767_20111103(:,4))<=1000),:)=[];
median_fluorescence_2767_resc2Ade((cell2mat(median_fluorescence_2767_resc2Ade(:,4))<=1000),:)=[];
median_fluorescence_2767_rescreen_2((cell2mat(median_fluorescence_2767_rescreen_2(:,4))<=1000),:)=[];

%Plot all rescreens


figure;
hold all;
%mark_col=[0 0 0];
%plot(cell2mat(median_fluorescence(:,2)),cell2mat(median_fluorescence(:,3)),'o','markerfacecolor',mark_col,'MarkerEdgeColor',mark_col,'MarkerSize',5);
%plot(cell2mat(normalized_median_fluorescence(:,2)),cell2mat(normalized_median_fluorescence(:,3)),'o','markerfacecolor',mark_col,'MarkerEdgeColor',mark_col,'MarkerSize',5);
mark_col=rand(1,3);
plot(cell2mat(median_fluorescence_161111(:,2)),cell2mat(median_fluorescence_161111(:,3)),'o','markerfacecolor',mark_col,'MarkerEdgeColor',mark_col,'MarkerSize',5);
mark_col=rand(1,3);
plot(cell2mat(median_fluorescence_2767_0311(:,2)),cell2mat(median_fluorescence_2767_0311(:,3)),'o','markerfacecolor',mark_col,'MarkerEdgeColor',mark_col,'MarkerSize',5);
mark_col=rand(1,3);
plot(cell2mat(median_fluorescence_2767_20111103(:,2)),cell2mat(median_fluorescence_2767_20111103(:,3)),'o','markerfacecolor',mark_col,'MarkerEdgeColor',mark_col,'MarkerSize',5);
mark_col=rand(1,3);
plot(cell2mat(median_fluorescence_2767_resc2Ade(:,2)),cell2mat(median_fluorescence_2767_resc2Ade(:,3)),'o','markerfacecolor',mark_col,'MarkerEdgeColor',mark_col,'MarkerSize',5);
mark_col=rand(1,3);
plot(cell2mat(median_fluorescence_2767_rescreen_2(:,2)),cell2mat(median_fluorescence_2767_rescreen_2(:,3)),'o','markerfacecolor',mark_col,'MarkerEdgeColor',mark_col,'MarkerSize',5);
set_bg_white;
xlabel('mCherry','fontsize',14);
ylabel('YFP','fontsize',14)
legend('16.11.11','2767.0311','20111103','2767_resc2Ade','rescreen_2')

%%Normalized data

figure;
hold all;
mark_col=[ 0.6602    0.6602    0.6602];
%plot(cell2mat(normalized_median_fluorescence(:,2)),cell2mat(normalized_median_fluorescence(:,3)),'o','markerfacecolor',mark_col,'MarkerEdgeColor',mark_col,'MarkerSize',5);
plot(cell2mat(b(:,2)),cell2mat(b(:,3)),'o','markerfacecolor',mark_col,'MarkerEdgeColor',mark_col,'MarkerSize',5);
lsline;
mark_col=rand(1,3);
normalized_median_fluorescence_161111=normalize_plates(median_fluorescence_161111);
plot(cell2mat(normalized_median_fluorescence_161111(:,2)),cell2mat(normalized_median_fluorescence_161111(:,3)),'o','markerfacecolor',mark_col,'MarkerEdgeColor',mark_col,'MarkerSize',5);
mark_col=rand(1,3);
normalized_median_fluorescence_2767_0311=normalize_plates(median_fluorescence_2767_0311);
plot(cell2mat(normalized_median_fluorescence_2767_0311(:,2)),cell2mat(normalized_median_fluorescence_2767_0311(:,3)),'o','markerfacecolor',mark_col,'MarkerEdgeColor',mark_col,'MarkerSize',5);
mark_col=rand(1,3);
normalized_median_fluorescence_2767_20111103=normalize_plates(median_fluorescence_2767_20111103);
plot(cell2mat(normalized_median_fluorescence_2767_20111103(:,2)),cell2mat(normalized_median_fluorescence_2767_20111103(:,3)),'o','markerfacecolor',mark_col,'MarkerEdgeColor',mark_col,'MarkerSize',5);
mark_col=rand(1,3);
normalized_median_fluorescence_2767_resc2Ade=normalize_plates(median_fluorescence_2767_resc2Ade);
plot(cell2mat(normalized_median_fluorescence_2767_resc2Ade(:,2)),cell2mat(normalized_median_fluorescence_2767_resc2Ade(:,3)),'o','markerfacecolor',mark_col,'MarkerEdgeColor',mark_col,'MarkerSize',5);
mark_col=rand(1,3);
normalized_median_fluorescence_2767_rescreen_2=normalize_plates(median_fluorescence_2767_rescreen_2);
plot(cell2mat(normalized_median_fluorescence_2767_rescreen_2(:,2)),cell2mat(normalized_median_fluorescence_2767_rescreen_2(:,3)),'o','markerfacecolor',mark_col,'MarkerEdgeColor',mark_col,'MarkerSize',5);
set_bg_white;
xlabel('median mCherry per well','fontsize',14);
ylabel('median YFP per well','fontsize',14)
legend('Complete.screen2767','least square fit to the screen 2767','16.11.11','2767.0311','20111103','2767.resc2Ade','rescreen.2');
%legend('16.11.11','2767.0311','20111103','2767_resc2Ade','rescreen_2')
title('Rescreens_2767','FontSize',14,'Interpreter','none')
hold off;

%Which are the mos extreme data points in quadrant 1
%Are the controls in wells H03, H04,H07, H08

figure;
mark_col=rand(1,3);
plot(cell2mat(median_fluorescence_161111(:,2)),cell2mat(median_fluorescence_161111(:,3)),'o','markerfacecolor',mark_col,'MarkerEdgeColor',mark_col,'MarkerSize',5);
gname(median_fluorescence_161111(:,1))

%Which are the mos extreme data points in quadrant 4
figure;
mark_col=rand(1,3);
plot(cell2mat(median_fluorescence_2767_resc2Ade(:,2)),cell2mat(median_fluorescence_2767_resc2Ade(:,3)),'o','markerfacecolor',mark_col,'MarkerEdgeColor',mark_col,'MarkerSize',5);
gname(median_fluorescence_2767_resc2Ade(:,1))


%
figure;
mark_col=rand(1,3);
plot(cell2mat(median_fluorescence_2767_20111103(:,2)),cell2mat(median_fluorescence_2767_20111103(:,3)),'o','markerfacecolor',mark_col,'MarkerEdgeColor',mark_col,'MarkerSize',5);
gname(median_fluorescence_2767_20111103(:,1))

%All the wells in the screen

figure;
mark_col=[0 0 0];
plot(cell2mat(median_fluorescence(:,2)),cell2mat(median_fluorescence(:,3)),'o','markerfacecolor',mark_col,'MarkerEdgeColor',mark_col,'MarkerSize',5);
gname(median_fluorescence(:,1))
