function [Y, InitialMatrix] = parse_data_set_file(file_path)
  si = fopen(file_path, 'r');
  n = fscanf(si, "%d", 1);
  m = fscanf(si, "%d", 1);

  fgetl(si);

  Y = zeros(n,1);
  InitialMatrix = cell(n,m);

  for i = 1:n
    line = fgetl(si);
    tokens = strsplit(line);
    Y(i,1) = str2num(tokens{1});
    for j = 1:m
      InitialMatrix{i,j} = tokens{j+1};
    endfor
  endfor
end
