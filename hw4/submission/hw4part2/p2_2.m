% p2-2
% question at end of section 2-2: combine train and test instances of 
% vaccine dataset and train svm using 2 partitions and 10 partitions, the
% test data being a randomly selected held out dataset
clear
clc
load('ps4-svm.mat')

C = 0.5;
Xtrain = [x_train;x_test];
Ytrain = [y_train;y_test];

% Linear Kernel - equivalent to no kernel
kernel = @(x,z) x'*z;
% kernel = @(x,z) gaussian_kernel(x, z);

% train svm for homework 4 data 

% 2 partitions and 10 partitions case;
Xtrain_2_test_labels = PartitionHeldOut(size(Xtrain,1),2);
Xtrain_10_test_labels = PartitionHeldOut(size(Xtrain,1),10);

Xtrain_2 = Xtrain(Xtrain_2_test_labels==0,:);
Ytrain_2 = Ytrain(Xtrain_2_test_labels==0,:);
Xtest_2 = Xtrain(Xtrain_2_test_labels==1,:);
Ytest_2 = Ytrain(Xtrain_2_test_labels==1,:);

Xtrain_10 = Xtrain(Xtrain_10_test_labels==0,:);
Ytrain_10 = Ytrain(Xtrain_10_test_labels==0,:);
Xtest_10 = Xtrain(Xtrain_10_test_labels==1,:);
Ytest_10 = Ytrain(Xtrain_10_test_labels==1,:);

% 2 partitions case: train model and test on 1 of partitions
model_linear_2 = svm_train(Xtrain_2, Ytrain_2,C, kernel);
pred_linear_2 = svm_classify(model_linear_2, Xtest_2);
acc_linear_2 = mean(pred_linear_2==Ytest_2);
[acc_2_95,low_2_95,high_2_95] = ConstructInterval(pred_linear_2,Ytest_2,0.95)
[acc_2_99,low_2_99,high_2_99] = ConstructInterval(pred_linear_2,Ytest_2,0.99)



% 10 partitions case: train model and test on 1 of partitions
model_linear_10 = svm_train(Xtrain_10, Ytrain_10,C, kernel);
pred_linear_10 = svm_classify(model_linear_10, Xtest_10);
acc_linear_10 = mean(pred_linear_10==Ytest_10);
[acc_10_95,low_10_95,high_10_95] = ConstructInterval(pred_linear_10,Ytest_10,0.95)
[acc_10_99,low_10_99,high_10_99] = ConstructInterval(pred_linear_10,Ytest_10,0.99)

% % 10 partitions case: train model and test on existing partition - for
% % debug
% model_linear_10 = svm_train(Xtrain_10, Ytrain_10,C, kernel);
% pred_linear_10 = svm_classify(model_linear_10, Xtrain_10);
% acc_linear_10 = mean(pred_linear_10==Ytrain_10);
% [acc_10_95,low_10_95,high_10_95] = ConstructInterval(pred_linear_10,Ytrain_10,0.95)
% [acc_10_99,low_10_99,high_10_99] = ConstructInterval(pred_linear_10,Ytrain_10,0.99)
% 

 %% 
 figure; scatter3(Xtrain(:,1),Xtrain(:,1), Ytrain);
