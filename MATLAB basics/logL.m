function logL = logL(n, p, omega, R, X)
    % logL computes the log-likelihood
    % Inputs:
    %   n      - Data length
    %   p      - Parameter p
    %   omega  - Scalar or vector of weights
    %   R      - Covariance matrix
    %   X      - Data matrix
    % Outputs:
    %   logL   - Log-likelihood value

    % Compute spectral decomposition of R
    [U, E] = eig(R);                % U: eigenvectors, E: eigenvalues (diagonal)
    eig_values = real(diag(E));     % Extract real part of eigenvalues
    R_inv = real(U * diag(1 ./ eig_values) * U'); % Compute R_inv using eigen-decomposition

    % Initialize sum
    sum_term = 0;

    % Compute the number of blocks
    k = floor(n / p);

    % Loop over the blocks
    for i = 2:k
        % Extract relevant parts of X
        X_curr = X(((i-1)*p+1):(i*p));
        X_prev = X(((i-2)*p+1):((i-1)*p));
        diff = X_curr - omega * X_prev;

        % Add to the sum
        sum_term = sum_term + (diff') * R_inv * diff;
    end

    % Compute determinant of R
    detR = prod(eig_values);

    % Compute the log-likelihood
    logL = ((k-1)*p*log(2*pi))/2 + ((k-1)*log(detR))/2 + sum_term;

    % Handle special cases
    if isnan(logL)
        logL = Inf;
    elseif ~isnan(logL) && logL < -1e+10
        logL = Inf;
    end
end
