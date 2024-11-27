function result = w_R_est(n, p, X)
    % w_R_est estimates R and w iteratively
    % Inputs:
    %   n - Number of observations
    %   p - Block size
    %   X - Data matrix
    % Outputs:
    %   result - Struct containing estimated w and R

    max_iter = 100;  % Maximum number of iterations
    R_hat = zeros(max_iter, p, p);  % Initialize R_hat array
    w_hat = zeros(max_iter, 1);     % Initialize w_hat vector

    % Initial estimate for R_hat and w_hat
    R_hat(1, :, :) = eye(p);        % Independent observations assumption
    w_hat(1) = w_est(n, p, squeeze(R_hat(1, :, :)), X);

    i = 2;
    while true
        % Update R_hat and w_hat
        R_hat(i, :, :) = R_est(n, p, w_hat(i-1), X);
        w_hat(i) = w_est(n, p, squeeze(R_hat(i, :, :)), X);

        % Compute log-likelihoods
        l1 = logL(n, p, w_hat(i), squeeze(R_hat(i, :, :)), X);
        l2 = logL(n, p, w_hat(i-1), squeeze(R_hat(i-1, :, :)), X);

        % Convergence check
        if ~isnan(l1 - l2)
            if abs(l1 - l2) < 1e-10 || i >= max_iter
                break;
            end
        end

        % Break if maximum iterations are reached
        if i >= max_iter
            break;
        end

        i = i + 1;
    end

    % Final estimates
    R_hat = R_hat(1:i, :, :);           % Keep only relevant iterations
    w_hat = w_hat(i);                   % Final estimate for w
    R_final = squeeze(R_hat(end, :, :));% Final estimate for R

    % Return results
    result.w = w_hat;
    result.R = R_final;
end
