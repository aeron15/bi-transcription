function dist_score=compute_dist(dsred_median,fitc_median,dsred,fitc)

dist_all=[];

%For every point in both dsred and fitc we calculate the distance to the
%line


for i=1:numel(dsred)
    
    d=dist_point_to_line(dsred(i),fitc(i),dsred_median,-(fitc_median));
    dist_all=[dist_all d];
    
end

dist_score=median(dist_all);

end

