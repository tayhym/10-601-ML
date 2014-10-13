function [cost, grad] = costNN(X, y, theta, opt)
% costNN  Neural network cost function.
%
% function [cost, grad] = costNN(X, y, theta, opt)
%
%   X     - m x n design matrix of m data points.
%   y     - k x m labels.
%   theta - flattened parameters for NN.
%   opt   - Struct must contain:
%          lambda        - regularization strength
%          hidden_sizes  - vector of number of units in each hidden layer. 
%                          In the case of a single hidden layer NN this 
%                          will be a scalar.
%
%   cost - cost at theta
%   grad - gradient at theta. i.e. [dJ/dx1, ..., dJ/dxn]' (n x 1 vector)
%
    visible_size = size(X, 2);
    hidden_size = opt.hidden_sizes;
    output_size = size(y, 1);
    
    n_layers = length(opt.hidden_sizes) + 1;

    all_layer_sizes = [visible_size; opt.hidden_sizes; output_size];
    
    [Ws, bs] = unflattenParameters(theta, all_layer_sizes);
    
    % You may find the following variables helpful.
    
    W1 = Ws{1}; % weights from layer 1 to layer 2.
    W2 = Ws{2}; % weights from layer 2 to layer 3.
    b1 = bs{1}; % biases to layer 2.
    b2 = bs{2}; % biases to layer 3.
    
    W1grad = zeros(hidden_size, visible_size);
    W2grad = zeros(output_size, hidden_size);
    b1grad = zeros(hidden_size, 1);
    b2grad = zeros(output_size, 1);
    
    Wgrads = cell(n_layers, 1); % Wgrads{i} = Wigrad
    bgrads = cell(n_layers, 1); % bgrads{i} = bigrad
    
    % in the case of single hidden layer NN.
    %      layer 1 = input layer
    %      layer 2 = hidden layer
    %      layer 3 = output layer
    
    %% Write your code below to compute the cost and gradients.
    % our solution is ~14 lines. You may assume that the NN has a single
    % hidden layer.
    %% BEGIN SOLUTION
    % compute front propogation to get terms 
    z2=W1*X' + repmat(b1,[1,size(X,1)]);    % z2 = 4 by 10 
    
    a2 = sigmoid(z2);                   
    z3 = W2*a2 + repmat(b2,[1,size(X,1)]);  % W2 is 2 by 4    
                                            % z3 is 2 by 10                             
    a3 = sigmoid(z3);                       % a3 is 2 by 10
    % compute the errors at each level
    d3 = (a3 - y).*sigmoid(z3).*(1-sigmoid(z3));   % d3 is 2 by m
    d2 = (W2'*d3).*sigmoid(z2).*(1-sigmoid(z2));   % d2 is 4 by m
        
    W2grad = W2grad +d3*(a2'); 
    W1grad = W1grad+d2*(X);
    b2grad = b2grad+sum(d3,2);  % sum across row (along column)
    b1grad = b1grad+sum(d2,2);
    
    lambda = opt.lambda;
    W2grad = W2grad + (lambda*W2); % regularization term
    W1grad = W1grad + (lambda*W1);
    errorSum = a3-y;
    cost = (lambda/2)*((norm(W1(:))^2)+(norm(W2(:))^2)) +(0.5*(norm(errorSum(:))^2));
    %% END SOLUTION
    
    Wgrads{1} = W1grad;
    Wgrads{2} = W2grad;
    bgrads{1} = b1grad;
    bgrads{2} = b2grad;
    
    grad = flattenParameters(Wgrads, bgrads);
    
end

function y = sigmoid(x)
    y = 1 ./ (1. + exp(-x));
end
