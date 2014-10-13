% given a division of the training set into k subsets, train the model
% k times, each time the testing set will vary from 1 to k
% the Ypredict will be the combined output from the predictions made by the
% k different (though dependent) models 
function [Ypredict] = TrainCrossSet(Xtrain, Ytrain, crossSetLabel)
    k = max(crossSetLabel); % number of partitions
    Ypredict = zeros(size(Ytrain,1),1); % same number of instances as Ytrain
    
    for i=1:k
        test_indx = crossSetLabel == i;
        Ypredict(test_indx) = TrainHeldOut(Xtrain,Ytrain,test_indx);
    end 
end 

        
        
    
    