function X = allZeroOneVectorsDim(n)
% ===> All Zero One Vectors in Dimension n <===
% PURPOSE:  create an {0,1}^{n x 2^{n}} matrix 
%           where every {0,1}^{n} vector appears
%           as some column in X (in binary order)
% INPUT:    n - dimension of the {0,1}-vectors
% OUTPUT:   X - {0,1}^{n x 2^{n}} matrix 

    nCol = 2^n;                     % Number of string
    X = dec2bin(0:nCol-1) - '0';    % Each row is bin-digits of a number
    X = X';                         % Each col is '''
end