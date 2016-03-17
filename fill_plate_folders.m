function fill_plate_folders()
%FILL_PLATE_FOLDERS automates the process of filling FCS plate export
% folders with the appropriate maps of {'Strains','Media','Time'}.csv
cd('data');
list = dir('2767-*');
names = cell(length(list),1);
for i=1:numel(list)
    names{i} = list(i).name;
end 
cd('..');
%
% Copy Media.csv and Strains.csv into each folder
%
for i=1:numel(names)
    
    if(regexp(names{i},'2767-'))
        
    copyfile('Media.csv',['data/' names{i} '/Media.csv']);
    copyfile('Strains.csv',['data/' names{i} '/Strains.csv']);
    t_name = regexprep(names{i},'2767-','Time_');
    times = cell(8,12);
    for a = 1:numel(times);
    times{a} = t_name;
    end
    cellwrite(['data/' names{i} '/Time.csv'],times);
    end
end
end