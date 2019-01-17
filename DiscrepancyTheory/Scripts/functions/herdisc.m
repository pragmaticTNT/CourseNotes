function [h,x] = herdisc(A)
%           TO DO 
% ===> Hereditary Discrepancy <===
% PURPOSE:  calculates the hereditary discrepancy of A.
%
% INPUTS:   A - matrix in \RR^{m x n}
%
% OUTPUT:   h - hereditary discrepancy
%           a - best sub-matrix
%           x - best colouring wrt a

    n = size(A,2);
    weight = 1/2 * ones(n,1); 
    [h,x] = lindiscWRTw(A, weight);
end
