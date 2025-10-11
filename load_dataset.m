function [X, y] = load_dataset(path)
  data = load(path);
  X = data.X;
  y = data.y;
end
