% construct confidence interval of the accuracy, with confidence level 
% confLevel, and assuming samples from binomial distribution
function [Accuracy, lowerInterval, upperInterval] = ConstructInterval(Ypredict,Ytest,confLevel)
    Accuracy = mean(Ypredict==Ytest);
    p = Accuracy;
%   n = size(Ytest,1); % sample size
    n = numel(Ytest);
    % assumption: that confidence level is 0.99 or 0.95
    tol = 1e-4;
    if (abs(confLevel-0.99)<tol)
        var = p/n - (p^2)/n;
        std_dev = sqrt(var);
        lowerInterval = Accuracy - 2.576*std_dev;
        upperInterval = Accuracy + 2.576*std_dev;
    else 
        lowerInterval = Accuracy - 1.960*sqrt(p*(1-p)/n);
        upperInterval = Accuracy + 1.960*sqrt(p*(1-p)/n);
    end 
end


