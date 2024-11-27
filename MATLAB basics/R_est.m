function R_est = R_est(n, p, omega, X)
    % R_est estimates the covariance matrix R
    % Inputs:
    %   n - Number of observations
    %   p - Block size
    %   omega - Weight parameter
    %   X - Data vector
    % Output:
    %   R_est - Estimated covariance matrix

    k = n / p; % Number of blocks
    S = zeros(p, p); % Initialize S matrix

    % Loop through blocks to compute S
    for i = 1:(k-1)
        % Extract relevant block segments
        x_current = X((i*p+1):((i+1)*p));
        x_prev = X(((i-1)*p+1):(i*p));
        
        % Compute the residual matrix for this block
        residual = x_current - omega * x_prev;
        
        % Accumulate the outer product
        S = S + residual * residual';
    end

    % Normalize by (k-1)
    R_est = S / (k-1);
end
