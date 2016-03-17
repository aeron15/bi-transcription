% read csv reads a comma separated values file and returns a matrix with
% the values

function MatrixRead=read_csv(file)

filename=file;

fid=fopen(filename,'r');

MatrixRead=[];

while ~feof(fid);
    
    line=fgetl(fid);
    
    line=make_string_array(line,char(44));
    
    %display(line);
    
    MatrixRead=[MatrixRead;line];
    
end;

fclose(fid);

end