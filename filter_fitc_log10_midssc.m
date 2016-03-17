function fitc = filter_fitc_log10_midssc(well,mid)
% FILTER_FITC_LOG10 filters flow cytometry data in WELL and returns FITC_H
%  values in log10 scale
% 
% WELL is the well where the data needs to be filtered
%
% MID is the middle

fitc = log10(well.FITC_H);
ssc = well.SSC_H;
%
% Filter from 1/3 to 8/9 time
%
fitc = fitc(floor(end/3):floor(end*8/9));
ssc = ssc(floor(end/3):floor(end*8/9));
%
% Remove erroneous values
%
err = isnan(fitc)|isinf(fitc)|isinf(ssc)|isnan(ssc);
fitc(err)=[];
ssc(err)=[];
%
% Remove data away from +/- 10% of median SSC Value
%

fitc(ssc > 1.1 * mid | ssc < .90 * mid) = [];
end