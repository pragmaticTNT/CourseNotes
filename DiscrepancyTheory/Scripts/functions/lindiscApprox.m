function [l,w,x] = lindiscApprox(A,ntrials)
% ===> Approximate Linear Discrepancy <===
% PURPOSE:  randomly sample ntrials number of weight
%           vectors and calculate the linear discrepancy.
%
% INPUTS:   A - matrix in \RR^{m x n}
%           ntrials - number of weight vectors to sample
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
    listX = allZeroOneVectorsDim(n);                % [listX]_{nx2^n} 
    l = 0;
    
    for i=1:ntrials
        weight = rand(n,1);
        W = repmat(weight,1,nX);                    % [W]_{nx2^n}
        [val, index] = min(max(abs(A*(listX-W)),[],1), [], 2);
        if val > l
            l = val;
            w = weight;
            x = listX(:,index);
        end
    end
end

