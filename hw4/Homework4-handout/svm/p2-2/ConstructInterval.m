% construct confidence interval of the accuracy, with confidence level 
% confLevel, and assuming samples from binomial distribution
function [Accuracy, lowerInterval, upperInterval] = ConstructInterval(Ypredict,Ytest,confLevel)
    Accuracy = mean(Ypredict==Ytest);
    p = Accuracy;
    n = size(Ytest,1); % sample size
    % assumption: that confidence level is 0.99 or 0.95
    if (confLevel==0.99)
        lowerInterval = Accuracy - 2.576*sqrt(p*(1-p)/n);
        upperInterval = Accuracy + 2.576*sqrt(p*(1-p)/n);
    else 
        lowerInterval = Accuracy - 1.960*sqrt(p*(1-p)/n);
        upperInterval = Accuracy + 1.960*sqrt(p*(1-p)/n);
    end 
end


