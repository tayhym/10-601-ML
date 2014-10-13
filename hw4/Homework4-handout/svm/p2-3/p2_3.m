% combines train and test sets of vaccine data 
clear
clc
load('ps4-svm.mat')

Xtrain = [x_train;x_test];
Ytrain = [y_train;y_test];


C_array = [0, 0.1, 0.3, 0.5, 1, 2, 5, 8, 10];
train_errors = zeros(1, length(C_array));
test_errors = zeros(1, length(C_array));
K = 4; % 4 fold-cross validation
cross_set_labels = PartitionCrossSet(size(Xtrain,1),K); 
% Linear Kernel - equivalent to no kernel
kernel = @(x,z) x'*z;
% kernel = @(x,z) gaussian_kernel(x, z);


for i=1:length(C_array)
    C = C_array(i);
    % train svm with no kernel with 4 fold cross validation
    for j=1:K
        train_idx = cross_set_labels~=j;
        x_train_set = Xtrain(train_idx,:);
        y_train_set = Ytrain(train_idx,:);
        
        test_idx = cross_set_labels ==j;
        x_test_set = Xtrain(test_idx,:);
        y_test_set = Ytrain(test_idx,:);
        
        model = svm_train(x_train_set, y_train_set,C,kernel);
        ypred_test = svm_classify(model, x_test_set);
        ypred_train = svm_classify(model,x_train_set);
        % sum of test errors
        test_errors(i) = test_errors(i) + mean(ypred_test~=y_test_set);
        % sum of train errors
        train_errors(i) = train_errors(i) + mean(ypred_train~=y_train_set);
    end 
end
    % normalize train errors
%     train_errors = train_errors/(K-1);
    
%% 
figure; plot(C_array,train_errors); title('train errors plot'); xlabel('C-higher C for more over-fitting'); ylabel('Average Train error');
figure; plot(C_array,test_errors); title('test errors plot'); xlabel('C-higher C for more over-fitting'); ylabel('Total Test error');
