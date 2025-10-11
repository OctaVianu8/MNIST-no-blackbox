function [classes] = predict_classes(X, weights, ...
                  input_layer_size, hidden_layer_size, ...
                  output_layer_size)
  [m,n] = size(X);
  K = output_layer_size;

  t1sz = hidden_layer_size * (input_layer_size + 1);
  Theta1 = reshape(weights(1 : t1sz), ...
                  hidden_layer_size, input_layer_size + 1);

  t2sz = output_layer_size * (hidden_layer_size + 1);
  Theta2 = reshape(weights(t1sz + 1 : t2sz + t1sz), ...
                  output_layer_size, hidden_layer_size + 1);

  % Forward propagation
  A1 = [ones(1,m) ; X'];
  Z2 = Theta1 * A1;
  A2 = sigmoid(Z2);
  A2 = [ones(1,m) ; A2];
  Z3 = Theta2 * A2;
  A3 = sigmoid(Z3);

  [~, classes] = max(A3);
  classes = classes';
end
