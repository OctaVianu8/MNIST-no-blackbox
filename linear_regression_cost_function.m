function [Error] = linear_regression_cost_function(Theta, Y, FeatureMatrix)
  [n, m] = size(FeatureMatrix);
  pred = FeatureMatrix * Theta(2:m+1);
  err_vect = Y - pred;
  Error = 1/(2*n) * sum(err_vect.^2)
end
