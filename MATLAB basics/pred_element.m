function pred = pred_element(n, p, w, R, X)
    % Predict the elements based on the input parameters n, p, w, R, and X
    pred = zeros(1, n); % Initialize the prediction vector
    
    for j = 1:n
        if mod(j, p) ~= 0
            i = floor(j / p);
            l = mod(j, p);
        else
            i = floor(j / p) - 1;
            l = p;
        end
        
        if j > p
            % Perform prediction when j > p
            pred1 = w * X((i-1)*p + l);
            pred2 = R(l, 1:(l-1)) * inv(R(1:(l-1), 1:(l-1))) * (X((i*p + 1):(i*p + l-1)) - w * X(((i-1)*p + 1):((i-1)*p + l-1)));
        else
            % Perform prediction when j <= p
            pred1 = 0;
            pred2 = R(l, 1:(l-1)) * inv(R(1:(l-1), 1:(l-1))) * X((i*p + 1):(i*p + l-1));
        end
        
        pred(j) = pred1 + pred2;
    end
end
