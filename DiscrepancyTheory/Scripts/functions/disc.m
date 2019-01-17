function [d,x] = disc(A)
% ===> Discrepancy <===
% PURPOSE:  calculates the discrepancy of A.
%
% INPUTS:   A - matrix in \RR^{m x n}
%
% OUTPUT:   d - discrepancy
%           x - best colouring
    
    n = size(A,2);
    weight = 1/2 * ones(n,1); 
    [d,x] = lindiscWRTw(A, weight);
end