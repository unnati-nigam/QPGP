function frob_norm = frob_norm_mackay(params, n, p, R, X)
    % Computes the Frobenius norm for the optimization
    % Inputs:
    %   params - [theta, sigma^2]
    %   n, p, R, X - Problem parameters
    % Output:
    %   frob_norm - Frobenius norm value
    
    theta = params(1);
    sig2 = params(2);
    
    % Example computation of the Frobenius norm (modify as per exact requirements)
    R_model = sig2 * toeplitz(exp(-theta^2 * (sin(pi * (0:(p-1)) / p)).^2));
    residual = R - R_model;
    frob_norm = norm(residual, 'fro'); % Frobenius norm
end
