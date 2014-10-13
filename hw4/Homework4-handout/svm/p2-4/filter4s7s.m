function [X_f, Y_f] = filter4s7s(X, Y)
    X_f = X(Y == 4 | Y == 7, :);
    Y_f = Y(Y == 4 | Y == 7);
    Y_f = Y_f == 7;
end