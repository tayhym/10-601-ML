function y_pred = predictLR(X, theta)
% PREDICTLR  Using fitted parameters, predict labels for data, X.
%           X      - m x n design matrix of m observations with n features.
%           theta  - (n+1) x 1 trained logistic regression parameters
%                    vector.
%
%           y_pred - predicted labels using trained model.

    [m, n] = size(X);
    
    % Predict the labels for X. Our solution is ~2 lines.
    
    %% BEGIN SOLUTION
    X_aug = [ones(size(X,1),1), X]; % add in intercept term
    y_pred = X_aug*theta>=0;         % weight inputs
%     theta
    %% END SOLUTION
end