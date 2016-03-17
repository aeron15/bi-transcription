
function FACS_data=load_facs_data

% ExcludedFolders={'Plate_1_T1',
%     'Plate_1_T2',
%     'Plate_1_T3',
%     'Plate_1_T4',
%     'Plate_1_T5',
%     'Plate_1_T6',
%     'Plate_1_T7',
%     'Plate_1_T9',
%     'Plate_1_T10',
%     'Plate_1_T11',
%     'Plate_1_T12',
%     'Plate_2_T1',
%     'Plate_2_T2',
%     'Plate_2_T3',
%     'Plate_2_T4',
%     'Plate_2_T5',
%     'Plate_2_T6',
%     'Plate_2_T7',
%     'Plate_2_T8',
%     'Plate_2_T9',
%     'Plate_2_T10',
%     'Plate_2_T11',
%     'Plate_2_T12'}


%'Plate_1_T7',
%    'Plate_1_T8'}

ExcludedFolders={};

FoldersToAnalyze=load_folders_plates(ExcludedFolders);

FACS_data_paths=load_fcs_path(FoldersToAnalyze,96);

plates=fieldnames(FACS_data_paths);

FACS_data=load_fcs_data(FACS_data_paths,plates);

end

% function [FACS_data,gal_conc_map]=load_facs_data
%
% % ExcludedFolders={'Plate_1_T1',
% %     'Plate_1_T5',
% %     'Plate_2_T1',
% %     'Plate_2_T5',
% %     'Plate_1_T2',
% %     'Plate_1_T6',
% %     'Plate_2_T2',
% %     'Plate_2_T6',
% %     'Plate_1_T3',
% %     'Plate_1_T7',
% %     'Plate_2_T3',
% %     'Plate_2_T7',
% %     'Plate_1_T4',
% %     'Plate_2_T4',
% %     'Plate_2_T8',
% %     'Plate_1_T9',
% %     'Plate_1_T10',
% %     'Plate_1_T11',
% %     'Plate_1_T12',
% %     'Plate_2_T9',
% %     'Plate_2_T10',
% %     'Plate_2_T11',
% %     'Plate_2_T12'}
% %     '%Plate_1_T8'}
%
%
% ExcludedFolders={'Plate_1_T8','Plate_2_T8'}
% %ExcludedFolders={};
%
% FoldersToAnalyze=load_folders_plates(ExcludedFolders);
%
% FACS_data_paths=load_fcs_path(FoldersToAnalyze,96);
%
% Strains=fieldnames(FACS_data_paths);
%
% FACS_data=load_fcs_data(FACS_data_paths,Strains);
%
% gal_conc_map=load('gal_conc_map.mat');
%
% end