%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% trains the naive bayes model (calculates the priors), 
% then tests the probabilities on Xtest, Ytest 
% then returns the accuracy
function [accuracy] = nb_run(Xtrain,Ytrain,Xtest,Ytest)
    model = nb_train(Xtrain,Ytrain);
    Pred_nb = nb_test(model,Xtest);
    accuracy = mean(Pred_nb==Ytest);
    save('Pred_nb.mat','Pred_nb');
end 
