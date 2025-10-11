function [X_train, y_train, X_test, y_test] = split_dataset(X, y, percent)
  [n m] = size(X);
  tr = round(n * percent);

  % le randomizez pt ca aparent testele sunt sortate 111222333445567788999
  idx = randperm(n);

  X = X(idx, :);
  y = y(idx, :);

  X_train = X(1:tr,:);
  y_train = y(1:tr,:);

  X_test = X(tr+1:n,:);
  y_test = y(tr+1:n,:);
end
