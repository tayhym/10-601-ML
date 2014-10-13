function kernel = polynomial_kernel(x, z)
% returns a polynomial kernel matrix with d = 2
    % returns polynomial for svm mapping
    d = 2;
    kernel = ((x'*z) + 1)^d;
    assert(sum(size(kernel))==2);
end 
