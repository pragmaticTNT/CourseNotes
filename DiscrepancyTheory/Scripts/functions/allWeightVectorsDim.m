function W = allWeightVectorsDim(n,interval)
% ===> All Weight Vectors in Dimension n <===
% PURPOSE:  create a subset of the weight vectors in
%           [0,1]^n to test the linear discrepancy
% INPUT:    n - dimension of the weight vectors
%           interval - number of intervals to subdivide [0,1]
% OUTPUT:   W - {0,1/interval, ..., interval/interval}^{n x 2^{n}} matrix 

    valW = 0:(1/interval):1;                % Row vector with possibles entries of W
    lenW = length(valW);                    % interval + 1
    W = zeros(n, lenW^n);                   % n x (interal+1)^n matrix of zeros
    for i = 1:n
        row = repelem(valW, lenW^(i-1));
        rep = repmat(row, 1, lenW^(n-i))';
        W(i,:) = rep;
    end
end

