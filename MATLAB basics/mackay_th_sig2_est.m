function params = mackay_th_sig2_est(n, p, R, X)
    % Estimates parameters theta and sigma^2 using optimization
    % Inputs:
    %   n - Number of observations
    %   p - Block size
    %   R - Covariance matrix
    %   X - Data vector
    % Output:
    %   params - Optimized parameters [theta, sigma^2]

    % Initial guess for theta and sigma^2
    initial_guess = [5,1]; 

    % Optimization options
    options = optimoptions('fmincon', ...
                           'Algorithm', 'sqp', ...                 % Gradient-based algorithm
                           'SpecifyObjectiveGradient', false);                    % Show iteration progress

    % Objective function
    objective = @(params) frob_norm_mackay(params, n, p, R, X);

    % Debug: Check initial objective value
%    disp(['Initial Objective Value: ', num2str(objective(initial_guess))]);

    % Perform optimization
    [params, fval, exitflag, output] = fmincon(objective, initial_guess, [], [], [], [], [0, 0], [], [], options);

 
end
