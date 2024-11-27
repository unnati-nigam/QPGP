function [f, grad] = frob_norm_mackay_with_grad(params, n, p, R, X)
    % Computes the Frobenius norm and its gradient
    % Inputs:
    %   params - Parameters [theta, sigma^2]
    %   n, p - Problem dimensions
    %   R - Covariance matrix (size [n x 1])
    %   X - Data matrix (size [n x m])
    % Outputs:
    %   f - Frobenius norm value
    %   grad - Gradient of the objective with respect to params

    % Extract parameters
    theta = params(1); % Assuming theta is scalar
    sigma2 = params(2); % Assuming sigma^2 is scalar

    % Compute the objective function
    residual = R - theta * X - sigma2 * ones(size(R)); % Residuals
    f = norm(residual)^2; % Frobenius norm squared

    % Compute the gradient
    grad_theta = -2 * sum(X .* residual); % Partial derivative w.r.t. theta
    grad_sigma2 = -2 * sum(residual);     % Partial derivative w.r.t. sigma^2

    % Combine gradients into a vector
    grad = [grad_theta; grad_sigma2];
end
