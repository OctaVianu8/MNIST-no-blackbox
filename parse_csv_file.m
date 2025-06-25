function [Y, InitialMatrix] = parse_csv_file(file_path)
  si = fopen(file_path, 'r');

  line = fgetl(si);
  token = strsplit(line, ',');
  m = length(token);

  i = 1;
  while ischar(line = fgetl(si))
    tokens = strsplit(line, ',');
    Y(i,1) = str2num(tokens{1});
    for j = 1:m-1
      InitialMatrix{i,j} = tokens{j+1};
    endfor
    i = i + 1;
  end
end
