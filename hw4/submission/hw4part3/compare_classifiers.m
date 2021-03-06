clear all; close all;
%---------compares classifiers---------%
load data/mnist.mat

lambda = 1; % Don't change this.

% filter 4s and 7s in the training and test set.

[X_train, Y_train] = filter4s7s(X_train, Y_train);
[X_test, Y_test] = filter4s7s(X_test, Y_test);

% split test data into K=10 categories
K=10;
test_size = floor(size(X_test,1)/K);

%%%%%%%%%%% train LR code %%%%%%%%%%
theta_LR = trainLR(X_train, Y_train, lambda); % you need to implement this function
% make predictions.

%%%%%%%%%%% train NN code %%%%%%%%%%

% Trains a single layer NN on a subset of the MNIST set and evaluates the
% NN.
    addpath ./helpers

    n_classes = 2;
    opt.hidden_sizes = 64;
    opt.lambda = 0.1;
    
    opt.MaxIter = 400; % max iterations for minimization function.
    
    opt.beta = 0.0;
    opt.p = 0.01;
    
    % labels from 1:2
    theta = nnTrainClassification(X_train, Y_train+1, opt);
    
    % visualize the weights we learned.
    Ws = unflattenParameters(theta, [28*28; opt.hidden_sizes; n_classes]);
    W1 = Ws{1};
    show_centroids((W1 - min(min(W1)))./max(max(W1 - min(min(W1)))),28,28);
    
    
% compute random variable y values (difference in error rates)
Y_i = zeros(K,1);


%%
for i=1:K
    test_start = ((i-1)*test_size) + 1;
    test_end = test_start + test_size - 1;
    X_test_set = X_test(test_start:test_end,:);
    Y_test_set = Y_test(test_start:test_end,:);

    % logistic regression test results
    Y_preds = predictLR(X_test_set, theta_LR); 
    
    % show the test accuracy 
    not_corrects_LR = Y_preds ~= Y_test_set;
    error_LR = mean(not_corrects_LR);
    fprintf('Logistic Regression Error: %.3f\n', error_LR); 
    
     % show the accuracy.
    preds = nnPredictClassification(X_test_set, theta, n_classes, opt);
    
    % dont forget to subtract 1 from the labels we added to earlier!
    not_corrects_NN = preds-1 ~= (Y_test_set');
    error_NN = mean(not_corrects_NN);
    fprintf('Neural Net error: %.3f\n', error_NN);
    
    % compute Y_i 
    Y_i(i) = error_LR - error_NN;
end


%%
% compute standard deviation and mean for t-test
Y_mean = mean(Y_i);
var = (1/(K-1))*sum((Y_i-Y_mean).^2);
Y_std_dev = sqrt(var);

% compute t-value
t_value = Y_mean*sqrt(K)/Y_std_dev;
