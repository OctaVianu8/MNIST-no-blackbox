function run_test()

    [X, y] = load_dataset("dataset.mat");

    input_layer_size = 400;
    hidden_layer_size = 25;
    output_layer_size = 10;
    
    m = size(X, 1);

    # We have a two-layered neural network
    initial_theta1 = initialize_weights(input_layer_size, hidden_layer_size);
    initial_theta2 = initialize_weights(hidden_layer_size, output_layer_size);

    initial_theta = [initial_theta1(:); initial_theta2(:)];

    lambda = 10;

    max_steps = 100;

    options = optimset('MaxIter', 100);

    curry_cost_function = @(params) cost_function(params, X, y, lambda, ...
                                        input_layer_size, ...
                                        hidden_layer_size, ...
                                        output_layer_size);
                                        
    [optimal_theta, cost] = fmincg(curry_cost_function, initial_theta, options);

    save('all_weights.mat', 'optimal_theta');

endfunction
