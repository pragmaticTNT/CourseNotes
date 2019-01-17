function [l,x] = lindiscWRTw(A, weight)
% ===> Linear Discrepancy WRT weight w <===
% PURPOSE:  calculate lindisc(A) given a weight vector w. 
%
% INPUTS:   A - matrix in \RR^{m x n}
%           weigth - vector in [0,1]^n
%
% OUTPUT:   l - linear discrepancy
%           x - best colouring wrt w
   
    n = size(A,2);
    nX = 2^n;
    listX = allZeroOneVectorsDim(n);            % [listX]_{nx2^n} 
    W = repmat(weight,1,nX);                    % [W]_{nx2^n}
    
    [val, index] = min(max(abs(A*(listX-W)),[],1), [], 2);
    
    l = val;
    x = listX(:,index);
end

