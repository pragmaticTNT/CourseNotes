function [l,w,x] = lindisc(A, interval)
% ===> Linear Discrepancy <===
% PURPOSE:  approximate lindisc(A) by sampling 
%           the weight vectors at intervals of 1/n. 
%           Keep n < 8, or this takes a long time
%           to run. Also try to keep m < 30 and 
%           n < 10 for similar reasons. 
%
% INPUTS:   A \in \RR^{m x n}
%           interval - the number of intervals to 
%           test the weights
%
% OUTPUT:   l - approximate linear discrepancy
%           w - approximate deep hole 
%           x - best colouring wrt w
% 
% COMMENT:  I could call lindiscWRTw for each w, but
%           that is pretty expensive since we would
%           need to reconstruct listX every time.
   
    n = size(A,2);
    nX = 2^n;
    nW = (interval + 1)^n;
    listX = allZeroOneVectorsDim(n);                % [listX]_{nx2^n} 
    listW = allWeightVectorsDim(n, interval);       % [listW]_{nx(interval+1)^n}
    l = 0;
    
    for i=1:nW
        weight = listW(:,i);
        W = repmat(weight,1,nX);                    % [W]_{nx2^n}
        [val, index] = min(max(abs(A*(listX-W)),[],1), [], 2);
        if val > l
            l = val;
            w = weight;
            x = listX(:,index);
        end
    end
end