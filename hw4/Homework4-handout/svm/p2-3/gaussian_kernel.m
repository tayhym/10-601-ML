function kernel = gaussian_kernel(x, z)
% returns a gaussian kernel matrix with gamma == 1/2 of vector x and vector z
% x and z must be in the same dimension
    % YOUR CODE HERE
    gamma = 0.5;
    kernel = exp(-(gamma)*(norm(x-z).^2));
end 

    