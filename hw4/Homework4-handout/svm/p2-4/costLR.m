function [cost, grad, hess] = costLR(X, y, theta, lambda)
% costLR  Logistic Regression cost function.
%
%   X      - m x (n+1) design matrix of m examples
%   y      - m x 1 labels
%   theta  - current logistic regression parameters. (nx1)
%   lambda - regularization term.
%
%   cost - cost at theta
%   grad - gradient at theta. i.e. [dJ/dx1, ..., dJ/dxn]' (n x 1 vector)
%   hess - hessian (symmetric matrix of second partial derivatives) at
%          theta, i.e.  (n x n matrix)
%             [d2J/dx1*dx1, d2J/dx1*dx2, ..., d2J/dx1*dxn;
%              d2J/dx2*dx1, d2J/dx2*dx2, ..., d2J/dx2*dxn;
%                 .               .                  .
%                 .               .                  .
%              d2J/dxn*dx1, d2J/dxn*dx2, ..., d2J/dxn*dxn]
%
%  When theta is a scalar, cost is just J(X,y,theta), grad is just
%   dJ(X,y,theta)/dtheta and hess is just d2J(X,y,theta)/dtheta^2.
%
%  Example usage:
%    cost = costLR(randn(100, 2), rand(100, 1) < 0.5, randn(2, 1));
%    [cost, grad] = costLR([1, 2; 1, 4], [0; 1], [0.1; 0.5])
%    [cost, grad, hess] = costLR(A, B, C); % hessian is optional
    
    % Write your solution below. If you choose to implement Newton's
    % method, please also compute hess. If you choose to just use gradient
    % descent, then the hessian is not required (you can just leave it
    % blank).
    % Our solution is approx 6 lines.
    
    %% BEGIN SOLUTION
    % useful variables 
    % non-vectorized cost for checking vectorized cost
%     m = size(X,1);
%     cost = (lambda/2)*(theta'*theta);  
%     grad = lambda*theta;   % theta: (n)x1
%     cost_sum = 0;
%     grad_sum = 0;
%     for i=1:m
%         x_i = X(i,:);  %1x(n)
%         y_i = y(i);    %y is mx1
%         z = x_i*theta;
%         
%         cost_contrib = y_i*(-1)*(logsumexp([0,-z])) + ...
%                        (1-y_i)*(logsumexp(-z)) - ...
%                        (1-y_i)*(logsumexp([0,-z]));
%         cost_sum = cost_sum + cost_contrib;
%         grad_contrib = (y_i - sigmoid(z))*x_i';
%         grad_sum = grad_sum + grad_contrib;
%     end 
%     
%         cost = cost-cost_sum;
%         grad = grad-grad_sum;  
   % vectorized cost
   z = X*theta;    % m x 1
   cost_contrib_vect = y*(-1).*(logsumexp(cat(2, zeros(length(z),1), -z))) + ...
                       (1-y).*(logsumexp(-z)) - ... 
                       (1-y).*(logsumexp(cat(2, zeros(length(z),1), -z)));
   cost = (lambda/2)*(theta'*theta) - sum(cost_contrib_vect);  % sum over each example
   grad_contrib_vec = (sum(repmat((y-sigmoid(z)),[1,size(X,2)]).*X,1))'; % sum across columns 
                                % m x 1          
   grad = lambda*theta - grad_contrib_vec;
%    assert(~sum(sum(abs(grad_vec-grad)<1e-6)) == 0);   % passed asserts
%    assert(~sum(sum(abs(cost_vec-cost)<1e-6)) == 0); 
     
    %% END SOLUTION
end

function y = logsumexp(x)
% LOGSUMEXP More numerically stable version of y = log(sum(exp(x), 2));
    b = max(x,[],2);
    y = log(sum(exp(x-repmat(b,[1, size(x,2)])),2))+b;
end

function y = sigmoid(x)
% SIGMOID  Computes sigmoid function, y = e^x/(1+e^x) = 1/(1+e^-x).
    y = 1./(1. + exp(-x));
end