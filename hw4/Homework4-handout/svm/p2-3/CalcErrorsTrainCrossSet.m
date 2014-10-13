% Same as TrainCrossSet function, but in each iteration, sum the 
% training error. The train error is then divided by k-1 to be normalized 
% to the original size of data. 
% TestError: the difference in predicted output and the actual data
function [TestError, TrainError] = CalcErrorsTrainCrossSet(Xtrain, Ytrain, crossSetLabel)
    k = max(crossSetLabel); % number of partitions
    Ypredict = zeros(size(Ytrain,1),1); % same number of instances as Ytrain
    TrainError = 0;
    
    for i=1:k
        test_indx = crossSetLabel == i;
        Ypredict(test_indx) = TrainHeldOut(Xtrain,Ytrain,test_indx);
        
        train_error_iteration = CalcErrorsTrainHeldOut(Xtrain, Ytrain, test_indx);
        TrainError = TrainError + train_error_iteration;
    end 
    TestError = mean(Ypredict~=Ytrain);
    TrainError = TrainError/(k-1);
end 

        
        
    
    