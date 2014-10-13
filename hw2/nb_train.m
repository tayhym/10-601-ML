%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% trains a model that distinguishes onion articles
% from economist articles.
% assumes that underlying model for word occurance 
% is multinomial, and that this approximates the ordered 
% word events. (i.e. uses naive bayes for word events)
% 
% Xtrain : n examples x V word features 
% Ytrain: n labels (1 - economist 0-onion)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [model] = nb_train(Xtrain, Ytrain)

% some useful variables
n = size(Xtrain, 1); 
V = size(Xtrain, 2); % num features (different types of words)


% to make a prediction, the priors are learned from the given 
% training data, and the conditional probabilities are learned as well 

% extract onion and economist articles
onion_a = Ytrain==0;
econ_a = Ytrain==1;

onions = Xtrain(onion_a,:);
econs = Xtrain(econ_a,:);

% calculate priors 
num_onions = size(onions,1);
num_econs = size(econs,1);

prior_onion = num_onions/n;
prior_econ = num_econs/n;

priors = [prior_onion prior_econ];

% calculate conditional probabilities
%-probability word occurs given article class
num_words_total_onion = sum(sum(onions));
num_words_total_econ = sum(sum(econs));
num_words_onion = sum(onions,1);
num_words_econ = sum(econs,1);

% use additive smoothing - smoothing operator that as alpha -> infinity 
% approximates uniform distribution sampling. a.k.a laplace smoothing

alpha = 1; % smoothing parameter
d = V; % num_outcomes
p_w_given_onion = (num_words_onion+alpha)./(num_words_total_onion+(alpha*d));
p_w_given_econ = (num_words_econ+alpha)./(num_words_total_econ+(alpha*d));


% create struct housing the probabilities

model = struct('priors',priors, 'conditionals_onion',p_w_given_onion, ...
               'conditionals_econ', p_w_given_econ);
           
end 
