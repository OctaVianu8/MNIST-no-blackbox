function [J, grad] = cost_function(params, X, y, lambda, ...
                   input_layer_size, hidden_layer_size, ...
                   output_layer_size)
  [m,n] = size(X);
  K = output_layer_size;

  % get Theta1 and Theta2 (from params). Hint: reshape
  t1sz = hidden_layer_size * (input_layer_size + 1);
  Theta1 = reshape(params(1 : t1sz), ...
                  hidden_layer_size, input_layer_size + 1);

  t2sz = output_layer_size * (hidden_layer_size + 1);
  Theta2 = reshape(params(t1sz + 1 : t2sz + t1sz), ...
                  output_layer_size, hidden_layer_size + 1);

  % Forward propagation
  A1 = [ones(1,m) ; X'];
  Z2 = Theta1 * A1;
  A2 = sigmoid(Z2);
  A2 = [ones(1,m) ; A2];
  Z3 = Theta2 * A2;
  A3 = sigmoid(Z3);

  % Compute the error in the output layer and perform backpropagation
  Y = zeros(size(A3));

  Y = eye(K)(:,y);

  Error = -Y .* log(A3) - (1 - Y) .* log(1 - A3);
  Error_unreg = sum(Error(:)) / m;

  nt1 = sum(sum(Theta1(:, 2:end).^2));
  nt2 = sum(sum(Theta2(:, 2:end).^2));

  J = Error_unreg + (lambda / (2*m)) * (nt1 + nt2);

  delta3 = A3 - Y;

  DELTA2 = delta3 * (A2)';
  delta2 = (Theta2(:, 2:end)' * delta3) .* sigmoidDerivat(Z2);

  DELTA1 = delta2 * (A1)';

  % Determine the gradients
  Th1_grad = (1 / m) * DELTA1;
  Th2_grad = (1 / m) * DELTA2;

  Th1_grad(:,2:end) = Th1_grad(:,2:end) + (lambda / m) * Theta1(:,2:end);
  Th2_grad(:,2:end) = Th2_grad(:,2:end) + (lambda / m) * Theta2(:,2:end);

  grad = [Th1_grad(:) ; Th2_grad(:)];

end

function g = sigmoidDerivat(z)
  g = sigmoid(z) .* (1 - sigmoid(z));
end
