function dsred = filter_dsred_log10_midssc(well,mid)
%FILTER_dsred_LOG10 filters flow cytometry data in WELL and returns dsred_H
%  values in log10 scale
dsred = log10(well.DsRed_H);
ssc = well.SSC_H;
%
% Filter from 1/3 to 8/9 time
%
dsred = dsred(floor(end/3):floor(end*8/9));
ssc = ssc(floor(end/3):floor(end*8/9));
%
% Remove erroneous values
%
err = isnan(dsred)|isinf(dsred)|isinf(ssc)|isnan(ssc);
dsred(err)=[];
ssc(err)=[];
%
% Remove data away from +/- 10% of median SSC Value
%
%mid = median(ssc);
dsred(ssc > 1.1 * mid | ssc < .90 * mid) = [];
end