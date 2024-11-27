function X = QPGPsim(n, p, theta, omega, sig2)
    % QPGPsim generates a quasi-periodic Gaussian process simulation
    % Inputs:
    %   n     - Length of the desired output
    %   p     - Periodicity parameter
    %   theta - Parameter controlling the covariance structure
    %   omega - Weighting factor for temporal dependence
    %   sig2  - Variance parameter
    % Output:
    %   X     - Simulated process

    % Construct the Toeplitz covariance matrix
    R = sig2 * toeplitz(exp(-theta^2 * (sin(pi * (0:(p-1)) / p)).^2));

    % Preallocate the output vector
    X = zeros(n, 1);

    % Initial segment
    X(1:p) = mvnrnd(zeros(1, p), R / (1 - omega^2));

    % Number of segments to generate
    k = floor(n / p);

    % Iteratively generate segments
    for i = 2:k
        X(((i-1)*p+1):(i*p)) = omega * X(((i-2)*p+1):((i-1)*p))' + mvnrnd(zeros(1, p), R);
    end
end
