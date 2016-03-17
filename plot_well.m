function [median_dsred,median_fitc]=plot_well(plates, plate, strain,mid)
%GET_WELL (different from GET_WELLS) returns a cell array of strains in PLATES that match the
%  provided criteria of strings STRAIN, MEDIA, and TIME. These criteria may
%  also be cell arrays of strings, in which case all matching combinations
%  will be returned.
%

dsred=plates.(plate).(strain).DsRed_H;
fitc=plates.(plate).(strain).FITC_H;

dsred=filter_dsred_log10_midssc(plates.(plate).(strain),mid);
fitc=filter_fitc_log10_midssc(plates.(plate).(strain),mid);

median_dsred=median(dsred);
median_fitc=median(fitc);
figure;
plot(dsred,fitc,'.','markerfacecolor','b','MarkerEdgeColor','b','MarkerSize',10);

xlim([2.3 3.3]);
ylim([2 3]);

set(gcf,'color',[1 1 1]);

title(strcat(plate,'_',strain,'_filter_global_mid_ssc'),'Interpreter','none');
                        

end