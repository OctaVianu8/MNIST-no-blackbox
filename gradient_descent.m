function [Theta] = gradient_descent(FeatureMatrix, Y, n, m, alpha, iter)

  Theta = zeros(n+1,1);
  for i = 1:iter

    pred = FeatureMatrix * Theta(2:n+1);
    diff = Y - pred;

    J = zeros(n,1);

    cnt = 0;
    for j = 1 : n

      J(j,1) = sum(diff .* FeatureMatrix(:,j)) / m;
    endfor
    Theta(2:n+1) = Theta(2:n+1) - alpha * J;
  endfor
  Theta = -Theta;
end
