function [Error] = ridge_regression_cost_function(Theta, Y, FeatureMatrix, lambda)
  [n, m] = size(FeatureMatrix);
  pred = FeatureMatrix * Theta(2 : m + 1);
  err_vect = Y - pred;
  Error = 1 / (2 * n) * sum(err_vect .^ 2);
  Error = Error + lambda * sum(Theta .^ 2);
end
