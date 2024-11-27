function var = pred_var(n, p, w, R, X)
    % Predict the variance for each element in the sequence
    var = zeros(1, n); % Initialize variance vector
    
    for j = 1:n
        if mod(j, p) ~= 0
            i = floor(j / p);
            l = mod(j, p);
        else
            i = floor(j / p) - 1;
            l = p;
        end
        
        R_star = R(l, 1:(l-1));
        R_star_t = R_star'; % Transpose of R_star
        R_inv = inv(R(1:(l-1), 1:(l-1)));
        
        if j > p
            % For j > p, calculate variance v using formula
            v = (w^2) * (R(l, l)) / (1 - w^2) + R_star_t * R_inv * R_star;
        else
            % For j <= p, calculate variance v using different formula
            v = (R_star_t * R_inv * R_star) / (1 - w^2);
        end
        
        var(j) = v; % Store the variance for element j
    end
end
