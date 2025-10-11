function predict()
    fout = fopen("prediction.txt", "w+");

    input_layer_size = 400;
    hidden_layer_size = 25;
    output_layer_size = 10;
    
    fin = fopen("input.txt", "r");
    X = fscanf(fin, '%lf');
    X = X';

    load('all_weights.mat');

    prediction = predict_classes(X, optimal_theta, ...
                            input_layer_size, ...
                            hidden_layer_size, ...
                            output_layer_size)

    % accuracy = sum(predictions == y_test) / length(y_test);
    fdisp(fout, prediction);

    fclose(fout);
endfunction
