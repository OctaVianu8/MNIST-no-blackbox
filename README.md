# MNIST-no-blackbox

A simple neural network for classifying handwritten digits from the MNIST dataset, implemented from scratch, without using high-level machine learning libraries. This project demonstrates the core concepts behind neural networks: forward propagation, backpropagation, and weight optimization.

The input consists of 20x20 pixel images (flattened to 400 features), and the network is trained to classify digits from 0 to 9.

## Features

Manual implementation of:

- Forward propagation
- Backpropagation
- Cost function computation
- Weight optimization using gradient descent

Simple dataset handling with train/test splitting
Prediction using the trained model

# Functions Overview

`load_dataset(path)`

Loads a `.mat` file containing the dataset.

`split_dataset(X, y, percent)`

Randomizes and splits the dataset into training and testing sets.

`initialize_weights(L_prev, L_next)`

Initializes the weight matrix between two layers.

Weights are randomly initialized in the interval (-ε, ε), where ε is computed based on the layer sizes (according to the standard formula to prevent vanishing/exploding gradients).


`cost_function(params, X, y, lambda, input_layer_size, hidden_layer_size, output_layer_size)`

Computes the cost and gradients for the neural network.

Process:

- Unpacks weight parameters (Theta1, Theta2) from params

- Performs forward propagation

- Computes the error (L2 norm between predictions and ground truth)

- Performs backpropagation to compute gradients

`predict_classes(X, weights, input_layer_size, hidden_layer_size, output_layer_size)`

Performs forward propagation to predict the class of each input sample.

## How to Run

Prepare the MNIST dataset in .mat format.

Run the provided functions in order:

- Load the dataset

- Split into training/testing

- Initialize weights

- Train the network using the cost function and an optimizer (e.g., fmincg, gradient descent)

- Evaluate accuracy using predict_classes

## License

This project is open-source under the MIT License.
