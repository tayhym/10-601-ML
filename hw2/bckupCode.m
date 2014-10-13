% calc another constant term in the formula (the sum of log(c_j!))
    document = Xtest(i,:);
    const2 = sum(log(factorial(document)),2);
    const1 = log(double(factorial(uint32(q)))); % convert to uint32 to have more 
                                        % digits for calculation (avoid inf)
    const = const1 - const2;
    
    % calculate and add the terms that vary with priors and conditional
    % probabilities.
    terms_o = sum(document.*log_cond_o + log_prior_o);
    terms_e = sum(document.*log_cond_e + log_prior_e);
    
    pred_o = terms_o + const
    pred_e = terms_e + const

    if (pred_e>pred_o)
        Pred_nb(i) = 1;
    end
    
    
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % impl 2
    counts = Xtest(i,:);
    const1 = log(double(factorial(uint32(q))));
    const2 = 0;
    for j=1:V
        const2 = const2 + log(factorial(counts(j)));
    end
    
    pred_onion = const1 - const2;
    pred_econ = const1 - const2;
    for j=1:V
        pred_onion = pred_onion + counts(j)*log(conditionals_onion(j)) ...
                     + log(priors_onion);
        pred_econ = pred_econ + counts(j)*log(conditionals_econ(j)) ...
                     + log(priors_econ);
    end
    
    if (pred_econ>pred_onion)
        Pred_nb(i) = 1;
    end