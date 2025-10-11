function [matrix] = initialize_weights(L_prev, L_next)
  e0 = sqrt(6)/ sqrt(L_prev + L_next);
  matrix = rand(L_next, L_prev + 1);
  matrix = (matrix * 2 * e0) - e0;
end
