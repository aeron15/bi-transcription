function [top_fract, top_dist, top_quad1_fract,top_quad3_fract]=get_hits_screen(plates,plates_all)

%GET_HITS_SCREEN returns the best hits, best hits distance and the best
%hits in quadrants 1 and 4 (previously 1 and 3)
%
%PLATES is the structure containing all the plates in the screen
%
%PLATES_ALL is a cell array with the names of a subset of platees to be
%analyzed from the screen

if(nargin<2)
    plates_all=fieldnames(plates);
else
    plates_all=plates_all;
end

for a=1:numel(plates_all)
    
    plate=plates_all{a}
    
    [rank_strains,rank_strains_dist,top_hits_quad1,top_hits_quad3]=get_hits_plate(plates,plate);
    
    %If the first plate is scored then we define the 4 structures below
    
    if(a==1|a==2)
        
        rank_strains_all=rank_strains;
        rank_strains_dist_all=rank_strains_dist;
        top_hits_quad1_all=top_hits_quad1;
        top_hits_quad3_all=top_hits_quad3;
        
    else
        %         rank_strains_all=[rank_strains_all;rank_strains];
        %         rank_strains_dist_all=[rank_strains_dist_all;rank_strains_dist];
        %
        rank_strains_all=merge_struct(rank_strains_all,rank_strains);
        rank_strains_dist_all=merge_struct(rank_strains_dist_all,rank_strains_dist);
        
        if(isstruct(top_hits_quad1))
            %top_hits_quad1_all=[top_hits_quad1_all;top_hits_quad1];
            top_hits_quad1_all=merge_struct(top_hits_quad1_all,top_hits_quad1);
        end
        
        if(isstruct(top_hits_quad3))
            %top_hits_quad3_all=[top_hits_quad3_all;top_hits_quad3];
            top_hits_quad3_all=merge_struct(top_hits_quad3_all,top_hits_quad3);
        end
        
    end
end

top_fract=filter_top_hits(rank_strains_all);
top_dist=filter_top_hits(rank_strains_dist_all);
top_quad1_fract=filter_top_hits(top_hits_quad1_all);
top_quad3_fract=filter_top_hits(top_hits_quad3_all);

 export_csv(top_fract,'top_fract');
 export_csv(top_dist,'top_dist');
 export_csv(top_quad1_fract,'top_quad1_fract');
 export_csv(top_quad3_fract,'top_quad4_fract');

end
