%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tests a document of length q, using a multinomial model
% the prior probabilities were calculated using the train dataset
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Pred_nb] = nb_test(model, Xtest)

% useful variables
m = size(Xtest,1);
V = size(Xtest,2);

% extract probabilities from model
priors = model.priors;
conditionals_onion = model.conditionals_onion;
conditionals_econ = model.conditionals_econ;
priors_onion = priors(1);
priors_econ = priors(2);

% calc log probabilities to avoid small numbers
log_cond_o = log(conditionals_onion);
log_cond_e = log(conditionals_econ);
log_prior_o = log(priors_onion);
log_prior_e = log(priors_econ);


Pred_nb = zeros(m,1); % vector of predictions for each of test documents

% loop over each training document, calculating probability
for i=1:m
    % calc q=num_words in test document
%     q = sum(Xtest(i,:),2);
    document = Xtest(i,:);
%     const2 = sum(log(factorial(document)),2);
%     const1 = log(double(factorial(uint32(q)))); % convert to uint32 to have more 
                                        % digits for calculation (avoid inf)
    
    % calculate and add the terms that vary with priors and conditional
    % probabilities. % remove constants to avoid infinities due to
    % insufficient precision when calculating in octave
    pred_o = sum(document.*log_cond_o) + log_prior_o;
    pred_e = sum(document.*log_cond_e) + log_prior_e;
    
    if (pred_e>pred_o)
        Pred_nb(i) = 1;
    end
    
    
end

end


