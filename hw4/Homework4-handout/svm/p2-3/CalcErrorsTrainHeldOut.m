% gives training error in 1 iteration of training using k-fold cross-validation 
function [train_error] = CalcErrorsTrainHeldOut(Xtrain, Ytrain, testInstanceLabel)
    Xtrain_set = Xtrain(testInstanceLabel==0,:);
    Ytrain_set = Ytrain(testInstanceLabel==0,:);
        
    model = nb_train(Xtrain_set, Ytrain_set);
    ytrain_predict = nb_test(model, Xtrain_set);
    train_error = mean(Ytrain_set~=ytrain_predict);
    
end

    
    
    
    
    
