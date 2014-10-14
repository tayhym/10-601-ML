% given a binary vector indicating which instances are examples and which 
% instances are to be held out for testing, train a naive bayes classifer,
% and use the classifier to predict the labels for the test set.
function [Ypredict] = TrainHeldOut(Xtrain, Ytrain, testInstanceLabel)
    Xtrain_set = Xtrain(testInstanceLabel==0,:);
    Ytrain_set = Ytrain(testInstanceLabel==0,:);
    
    Xtest_set = Xtrain(testInstanceLabel==1,:);
%     Ytest_set = Ytrain(testInstanceLabel==1,:);
    
    % convert the -1 classes to 0 to be compatible with naive bayes
    % classifier
%     Ytrain_set_idx = Ytrain_set == -1;
%     Ytrain_set(Ytrain_set_idx) = 0;
%     Ytest_set_idx = Ytest_set == -1;
%     Ytest_set(Ytest_set_idx) = 0;
    
    model = nb_train(Xtrain_set, Ytrain_set);
    Ypredict = nb_test(model, Xtest_set);

    % convert the 0 back to -1 to be compatible with original class labels
%     Ypredict_idx = Ypredict==0;
%     Ypredict(Ypredict_idx) = -1;
%     Ytest = Ytrain(testInstanceLabel==1,:);
end

    
    
    
    
    
