function result = par_est(n, p_search, X)
    % par_est estimates parameters based on log-likelihood maximization
    % Inputs:
    %   n        - Data length
    %   p_search - Vector of candidate values for parameter p
    %   X        - Data matrix
    % Outputs:
    %   result   - A structure containing:
    %              p_est: Estimated p
    %              w_cap: Estimated w
    %              R_cap: Estimated R

    % Initialize storage
    l = zeros(1, length(p_search)); % Log-likelihood values

    % Loop over the candidate values for p
    for i = 1:length(p_search)
        % Compute w and R using w_R_est function
        var = w_R_est(n, p_search(i), X);
        w = var.w;
        R = var.R;

        % Compute log-likelihood
        l(i) = logL(n, p_search(i), w, R, X);
    end

    % Find the index of the minimum log-likelihood
    [~, ind] = min(l);

    % Get the best p value
    p_est = p_search(ind);

    % Compute w and R for the estimated p
    var = w_R_est(n, p_est, X);
    w_cap = var.w;
    R_cap = var.R;

    % Return the results in a structure
    result = struct('p', p_est, 'w', w_cap, 'R', R_cap);
end
