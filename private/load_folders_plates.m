
function FoldersToAnalyze=load_folders_plates(ExcludedFolders)


%LOAD_FOLDERS_PLATES returns all the folders with plate data per folder
%If the argument ExcludedFolders (a cell array with names of folders) is included some folders are left out of the analysis, i.e. plates that the user does
%not want to analyse

FoldersToAnalyze=dir('data');
FoldersToAnalyze={FoldersToAnalyze(:).name};


%The '.', '..' and '.DS_Store' folders are excluded

FoldersToAnalyze(strcmp(FoldersToAnalyze,'.'))=[];

FoldersToAnalyze(strcmp(FoldersToAnalyze,'..'))=[];

FoldersToAnalyze(strcmp(FoldersToAnalyze,'.DS_Store'))=[];

FoldersToAnalyze(strcmp(FoldersToAnalyze,'private'))=[];



%Also exclude folders, i.e. plates that the user wants to leave out of the
%analysis
if nargin==1
    
    if ~(numel(ExcludedFolders)==0)
        
        display(' ')
        display('*** Excluding Folders,i.e., Plates ***');
        display(ExcludedFolders);
        
        
        for a=1:numel(ExcludedFolders)
            
            FoldersToAnalyze(strcmp(FoldersToAnalyze,ExcludedFolders{a}))=[];
            
        end
        
        
    end
    
end

end