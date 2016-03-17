
function best_hits=filter_best_hits(rank_strains,number_hits)

%return fract_quad and save value

%order based on this criterion

%extract  score and order

%this vector is used to determine the ranking at the end


strains=fieldnames(rank_strains);
rank=[];

for i=1:numel(strains)
    
    %rank_strains.(strains{i})
    rank=[rank;rank_strains.(strains{i})];
    
end


[a,ix]=sort(rank,'descend');


for i=1:length(ix)
    
    orderedstrains{i}=strains{ix(i)};
    
end

best_hits=orderfields(rank_strains,orderedstrains);


%
% Extract first  hits
%

if(nargin>1)
    
    
    strains=fieldnames(best_hits);
    
    strains(1:number_hits);
    
    for a=1:number_hits
        best_hits_subset.(strains{a})=best_hits.(strains{a});
    end
    
    best_hits=best_hits_subset;
end
end

