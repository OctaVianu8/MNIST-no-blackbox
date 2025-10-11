function run_test()

    [X, y] = load_dataset("dataset.mat");

    input_layer_size = 400;
    hidden_layer_size = 25;
    output_layer_size = 10;

    cop = X(2000,:)';

    # trebuie sa fie 3 - 2000
    save('data.txt', 'cop')

    % y(2000)
endfunction
