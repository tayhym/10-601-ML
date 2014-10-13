function theta = minimize(f, init_theta)
% MINIMIZE  Find a local minima of a function f, starting at init_theta.
%          f - function to be minimized. f should be of the form:
%              [cost, grad(, hess)] = f(theta)
    tol = 1e-6; % you should stop optimization when the absolute difference
                % in cost between two iterations is less than tol.
                
    maxIter = 1000; % you should alternatively break after maxIter.
    alpha = 0.02;  % changed from 0.1
    alpha_decay = 0.998;
    % Write your solution below. You should use either gradient descent or
    % Newton-Raphson to find the (local) minimum of the function.
    % Our solution is ~10 lines
    %% BEGIN SOLUTION (GRADIENT DESCENT)
    [cost, grad] = f(init_theta);
    % what is the cost? it is the cost function 
    % what is the grad? it is the derivative of the cost function
    % what is the minimized value? it is the weights that give min cost
    % possible bug: in grad and in grad descent (why only 2 idx????)
    idx = 1;
    theta=init_theta;
    diff = 0;
%     intial_cost = cost-tol
    while (idx==1 || abs(diff)>tol) 
        % compute the i+1th theta using ith gradient
        theta = theta - (alpha*(alpha_decay^idx)*grad);
        % compute i+1th gradient
        [new_cost, grad] = f(theta);
        diff = new_cost - cost;
        cost = new_cost    
        idx = idx+1
        if (idx>=maxIter)
            break;
        end
    end 
    
    %% BEGIN SOLUTION (NEWTON'S METHOD)
  
    %% END SOLUTION
end
