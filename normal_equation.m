function [Theta] = normal_equation(FeatureMatrix, Y, tol, iter)

  [n m] = size(FeatureMatrix);

  X = FeatureMatrix;
  x_0 = zeros(m,1);
  Theta = Conjugate_Gradient(X' * X, X' * Y, x_0, tol, iter);
  Theta = [0; Theta];
end

function x = Conjugate_Gradient(A, b, x_0, tol, max_iter)
  r = b - A*x_0;
  v = r;
  x = x_0;
  tol_sq = tol * tol;
  k = 1;
  while k <= max_iter && r'*r > tol_sq
    rr = r' * r;
    Av = A * v;
    vAv = v' * Av;

    t = rr / vAv;
    x = x + t * v;
    r = r - t * Av;
    s = (r' * r) / rr;
    v = r + s * v;
    k = k + 1;
  endwhile
end
