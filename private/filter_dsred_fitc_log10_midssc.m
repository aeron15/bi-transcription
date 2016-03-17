function [dsred,fitc] = filter_dsred_fitc_log10_midssc(well,mid)
%FILTER_DSRED_FITC_LOG10 filters flow cytometry data in WELL and returns
%dsred_H and fitc_H  values in log10 scale
dsred = log10(well.DsRed_H);
fitc = log10(well.FITC_H);
ssc = well.SSC_H;
%
% Filter from 1/3 to 8/9 time (e.g. for 10 000 cells discard the first 3333
% and the last 1111 for a total of 4 444 cells
%
dsred = dsred(floor(end/3):floor(end*8/9));
fitc = fitc(floor(end/3):floor(end*8/9));
ssc = ssc(floor(end/3):floor(end*8/9));
%
% Remove erroneous values
%
err = isnan(dsred)|isinf(dsred)|isinf(ssc)|isnan(ssc)|isnan(fitc)|isinf(fitc);
dsred(err)=[];
fitc(err)=[];
ssc(err)=[];
%
% Remove data away from +/- 10% of median SSC Value
%
%mid = median(ssc);
dsred(ssc > 1.1 * mid | ssc < .90 * mid) = [];
fitc(ssc > 1.1 * mid | ssc < .90 * mid) = [];

end