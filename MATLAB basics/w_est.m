function w_est = w_est(n, p, R, X)
    % w_est estimates the parameter w
    % Inputs:
    %   n - Number of observations
    %   p - Block size
    %   R - Covariance matrix
    %   X - Data vector
    % Output:
    %   w_est - Estimated w value

    k = floor(n / p); % Number of blocks

    % Spectral decomposition of R
    [U, D] = eig(R); 
    e = diag(D); % Eigenvalues
    R_inv = U * diag(1 ./ e) * U'; % Inverse of R using spectral decomposition

    % Compute numerator (i1i) and denominator (ii)
    i1i = 0; % Initialize numerator
    for i = 2:k
        x1 = X(((i-2)*p+1):((i-1)*p));
        x2 = X(((i-1)*p+1):(i*p));
        i1i = i1i + x1' * R_inv * x2;
    end

    ii = 0; % Initialize denominator
    for i = 1:(k-1)
        x = X(((i-1)*p+1):(i*p));
        ii = ii + x' * R_inv * x;
    end

    % Compute w estimate
    w_est = i1i / ii;
end
