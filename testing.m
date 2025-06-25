load("normal_eq1");
tol = 1e-10;
max_iter = 200;
[Theta] = normal_equation(X, y, tol, max_iter);
