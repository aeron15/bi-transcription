function [quad, fract_quad, mark_col, count_quad]=test_diff_dsred_fitc(dsred_mean,fitc_mean,dsred,fitc)

%
%TEST_DIFF_DSRED_FITC divides the data in 4 quadrants (1,2,3 and 4) defined by the values of DSRED_MEAN and FITC_MEAN.
%Then it returns a hit if more than a certain percentage of the popualtion of cells is contained
%within a quadrant
%
%DSRED_MEAN is the median or mean dsred (mCherry) value in the plate
%
%FITC_MEAN is the median or mean fitc (YFP) value in the plate
%
%DSRED are the dsred values in the sample
%
%FITC are the fitc values in the sample.
%
%QUAD is the quadrant with the most cells (identified by a number) if a tie
%is found then a vector is returned
%
%FRACT_QUAD is the fraction of cells in the quadrant with the most cells
%
%MARK_COL is a vector with the color used to identify the different hits
%(argument used by get_hits_plate_graphic)
%

mark_col=[0 0 1];

%%
%Cells in quadrant I
%

indx_1=dsred<=dsred_mean;
indx_2=fitc>=fitc_mean;

intersect_indx=indx_1+indx_2;

intersect_indx=(intersect_indx==2);

quad1=sum(intersect_indx);

%Calculate fraction of cells in quad I

fract_1=quad1/numel(dsred);

%%
%Cells in quadrant II
%

indx_1=dsred>=dsred_mean;
indx_2=fitc>=fitc_mean;

%indx_1=dsred<=dsred_mean;
%indx_2=fitc<=fitc_mean;

intersect_indx=indx_1+indx_2;

intersect_indx=(intersect_indx==2);

quad2=sum(intersect_indx);

%Calculate fraction of cells in quad 1

fract_2=quad2/numel(dsred);

%%
%Cells in quadrant III
%

indx_1=dsred<=dsred_mean;
indx_2=fitc<=fitc_mean;

%indx_1=dsred>=dsred_mean;
%indx_2=fitc<=fitc_mean;

intersect_indx=indx_1+indx_2;

intersect_indx=(intersect_indx==2);

quad3=sum(intersect_indx);

%Calculate fraction of cells in quad 1

fract_3=quad3/numel(dsred);



%%
%Cells in quadrant IV
%

indx_1=dsred>=dsred_mean;
indx_2=fitc<=fitc_mean;

%indx_1=dsred>=dsred_mean;
%indx_2=fitc>=fitc_mean;

%Extract positions of the indx_1 vector and indx_2 vector where both
%positions are 1

%If we sum them element by element we'll get 2, then we find all the
%positions where we have two
intersect_indx=indx_1+indx_2;

intersect_indx=(intersect_indx==2);

%count the number of cells in that quadrant

quad4=sum(intersect_indx);

fract_4=quad4/numel(dsred);


%We can plot all the identified cells

% figure;scatter(dsred(intersect_indx),fitc(intersect_indx));
% hline(fitc_mean,'r');
% vline(dsred_mean,'r');
%%
%Determine the quadrant with the most elements and determine if more than
%70% of the population is in that quadrant

fract_all=[fract_1 fract_2 fract_3 fract_4];
cell_count=[quad1 quad2 quad3 quad4];


%Return the quadrant where most of the cells are found
quad=find(fract_all==max(fract_all));

fract_quad=fract_all(quad);
count_quad=cell_count(quad);

if(numel(quad)==1)
    
    if(fract_quad>0.4)
        
        %display('We have a winner!!!');
        
        switch quad
            
            case 1
                %black for quadrant 1
                mark_col=[0 0 0];
                
            case 2
                
                %green for quadrant 2
                mark_col=[0 0 1];
                
            case 3
                
                %red for quadrant 3
                mark_col=[0 0 1];
                
            case 4
                
                %orange for quadrant 4
                mark_col=[ 1 0.6445 0];
                
                
        end
        
    end
    
else
    
    display('Tie between quadrants')
    
    %Just one value is returned for ties
    
    fract_quad=fract_quad(1);
    count_quad=count_quad(1);
    
    quad_tmp=cellstr(num2str(quad));
    %Remove all blank spaces
    quad_tmp2=regexprep(quad_tmp,'[^\w'']','');
    quad_tmp3=str2double(quad_tmp2);
    quad=quad_tmp3;
    
    
end

end