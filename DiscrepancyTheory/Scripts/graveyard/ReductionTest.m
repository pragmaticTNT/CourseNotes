nTrial = 1;
n = 5;

for i = 1:nTrial
    %A = naesatInstance(n);
    
    A = [
    1, 0, 0, 1, 1;
    0, 1, 0, -1, 1;
    -1, 1, 0, -1, 0;
    -1, -1, 0, 0, -1;
     0, -1, 1, 0, 1;
     0, 0, 1, -1, -1;
     0, 1, -1, 1, 0;
     1, 0, 0, -1, -1;
     0, -1, 1, 1, 0;
     0, 1, 0, 1, 1;
     1, -1, 0, 0, -1;
     0, 0, 1, -1, 1;
     0, 1, -1, 1, 0;
     1, -1, 0, 1, 0
     ];
    
    [w, x, val] = approxLindisc(A);
    fprintf("-");
    if mod(i,40) == 0
        fprintf("\n");
    end
    if val >= 0
        disp(A);
        disp(w);
        disp(x);
        fprintf("\nlindisc(A): %.6f\n", val);
    end
end
fprintf(">\n");

function W = getW(n)
    inc = [0, 0.25, 0.5, 0.75, 1];
%    inc = [0, 1/5, 1/4, 2/5, 1/2, 3/5, 3/4, 4/5, 1];
%    inc = [0, 1/5, 2/5, 3/5, 4/5, 1];
%   inc = [0, 1/8, 1/4, 3/8, 1/2, 5/8, 3/4, 7/8, 1];
    nInc = size(inc,2);
    W = zeros(n, nInc^n);
    for i = 1:n
        row = repelem(inc, nInc^(i-1));
        rep = repmat(row, 1, nInc^(n-i))';
        W(i,:) = rep;
    end
end

function value = disc(A)
    value = false;
    n = size(A,2);
    nStr = 2^n;
    X = allBinaryStrLen(n);
    center = 0.5*ones(n,1);
    for i = 1:nStr
        if norm(A*(X(:,i)-center),inf) < 0.6
            value = true;
            break;
        end
    end
end

function S = naesatInstance(n)
    nSet = n+randi(2*n);
    S = zeros(nSet,n);
    for i=1:nSet
        vars = randperm(n,3);
        row = zeros(1,n);
        row(vars(1)) = 2*randi(2)-3;
        row(vars(2)) = 2*randi(2)-3;
        row(vars(3)) = 2*randi(2)-3;
        S(i, :) = row;
        if ~disc(S)
            S(i, :) = zeros(1,n);
        end
    end
end

function S = mononaesatInstance(n)
    nSet = n+randi(2*n);
    S = zeros(nSet,n);
    for i=1:nSet
        vars = randperm(n,3);
        row = zeros(1,n);
        row(vars) = 1;
        S(i, :) = row;
        if ~disc(S)
            S(i, :) = zeros(1,n);
        end
    end
end

function [w,x,l] = approxLindisc(A)
    n = size(A, 2);
    nColor = 2^n;
    maxVal = 0;
    bestW = zeros(n,1);
    bestX = zeros(n,1);
    X = allBinaryStrLen(n);
    testW = getW(n);
    nW = size(testW,2);
    for i = 1:nW
        w = testW(:,i);
        W = repmat(w,1,nColor); 
        prod = A*(W-X);
        infNorm = max(abs(prod));
        [minVal, index] = min(infNorm);
        if minVal > maxVal
            maxVal = minVal;
            bestW = w;
            bestX = X(:,index);
        end
    end
    w = bestW;
    x = bestX;
    l = maxVal;
end

function X = allBinaryStrLen(n)
    nCol = 2^n;
    X = zeros(n, nCol);
    for j = 1:nCol
        for i = 1:n
            X(i,j) = bitget(j,i);
        end
    end
end


% sat = [-1,-1,1,0,0,0; 
%         1,-1,-1,0,0,0; 
%         1,0,1,-1,0,0;
%         0,0,0,1,1,-1;
%         0,0,0,1,1,1;
%         1,0,0,0,1,-1;
%         1,0,0,0,1,1;
%         ];