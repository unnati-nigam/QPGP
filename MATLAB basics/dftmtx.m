function F = dftmtx(n)
    % Generates the Discrete Fourier Transform (DFT) matrix of size n x n
    % Input:
    %   n - Size of the DFT matrix
    % Output:
    %   F - The DFT matrix of size n x n
    
    omega = exp(-2i * pi / n); % Primitive n-th root of unity
    F = zeros(n); % Initialize an n x n matrix with zeros
    
    for k = 0:(n-1)
        for j = 0:(n-1)
            F(k+1, j+1) = omega^(k * j); % DFT matrix element
        end
    end
end
