% test construct interval
% regular case
p = 0.023;
n = 10; % sample test
tol = 1e-4;
var = p/n - (p^2)/n;
std_dev = sqrt(var);
Accuracy = p;
lowerInterval = Accuracy - 2.576*std_dev
% lowerInterval = Accuracy - 2.576*sqrt(p*(1-p)/n)

upperInterval = Accuracy + 2.576*std_dev
% upperInterval = Accuracy + 2.576*sqrt(p*(1-p)/n)
upperInterval-lowerInterval
correct_possibly = 0.1221*2
diff = abs(upperInterval-lowerInterval-(0.1221*2))
assert(abs(upperInterval-lowerInterval-(0.1221*2))<tol);


% lowerInterval = Accuracy - 1.960*sqrt(p*(1-p)/n);
% upperInterval = Accuracy + 1.960*sqrt(p*(1-p)/n);
% assert((upperInterval-lowerInterval)-(0.0062*2)<tol);
% very small probability
% p = 1e-100;
% n = 50;

% test construct interval
% regular case
p = 0.000023;
n = 10; % sample test
tol = 1e-4;
var = p/n - (p^2)/n;
std_dev = sqrt(var);
Accuracy = p;
lowerInterval = Accuracy - 2.576*std_dev
% lowerInterval = Accuracy - 2.576*sqrt(p*(1-p)/n)

upperInterval = Accuracy + 2.576*std_dev
% upperInterval = Accuracy + 2.576*sqrt(p*(1-p)/n)
upperInterval-lowerInterval
correct_possibly = 0.0039*2
diff = abs(upperInterval-lowerInterval-(0.0039*2))
assert(abs(upperInterval-lowerInterval-(0.0039*2))<tol);


