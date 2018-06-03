unsat = [1, 1, 1; 1, 1, -1; 1, -1, 1; -1, 1, 1];
% sat = [-1, -1, 1, 0, 0; 
%         1, 1, -1, 0, 0; 
%         1, -1, 1, 0, 0; 
%         -1, 1, 1, 0, 0; 
%         1, -1, -1, 0, 0; 
%         -1, 1, -1, 0, 0; 
%         0, 1 , 1, -1, 0;
%         0, 1, -1, -1, 0;
%         0, -1, 1, -1, 0;
%         0, -1, -1, 1, 0;
%         1, 0, -1, -1, 0;
%         -1, 0, 1, -1, 0;
%         -1, 0, -1, 1, 0;
%         1, 0, 1, -1, 0;
%         -1, 0, 1, 1, 0;
%         1, 0, -1, 1, 0;
%         1, 0, 1, -1, 0;
%         1, -1, 0, -1, 0;
%         -1, -1, 0, 1, 0;
%         -1, 1, 0, -1, 0; 
%         1, 1, 0, -1, 0;
%         1, -1, 0, 1, 0;
%         -1, 1, 0, 1, 0;
%         0, 0, 1, 1, 1;
%         0, 0, -1, -1, -1;
%         1, 0, 0, 1, 1;
%         -1, 0, 0, -1, -1;
%         1, 1, 0, 0, 1;
%         ];
sat = [-1,-1,1,0,0,0; 
        1,-1,-1,0,0,0; 
        1,0,1,-1,0,0;
        0,0,0,1,1,-1;
        0,0,0,1,1,1;
        1,0,0,0,1,-1;
        1,0,0,0,1,1;
        ];
sat2 = [1,1,1,0,0,0,0; 0,0,0,1,1,1,0; 0,0,1,0,0,1,1];

[unsatw, unsatx, unsatval] = approxLindisc(unsat);
[satw, satx, satval] = approxLindisc(sat);
[sat2w, sat2x, sat2val] = approxLindisc(sat2);

fprintf("UNSAT: %.6f\n", unsatval);
fprintf("SAT: %.6f\n", satval);
disp(satw);
disp(satx);
%fprintf("SAT2: %.6f\n", sat2val);
%disp(sat2w);
%disp(sat2x);

function W = getW(n)
    inc = [0, 0.25, 0.5, 0.75, 1];
    nInc = size(inc,2);
    W = zeros(n, nInc^n);
    for i = 1:n
        row = repelem(inc, nInc^(i-1));
        rep = repmat(row, 1, nInc^(n-i))';
        W(i,:) = rep;
    end
end

function [w,x,l] = approxLindisc(A)
    n = size(A, 2);
    nColor = 2^n;
    %trials = 10;
    maxVal = 0;
    bestW = zeros(n,1);
    bestX = zeros(n,1);
    X = zeros(n, nColor);
    for j = 1:nColor
        for i = 1:n
            X(i,j) = bitget(j,i);
        end
    end
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

    
%     for i = 1:trials
%         w = rand(n,1);
%         W = repmat(w,1,nColor); 
%         prod = A*(W-X);
%         infNorm = max(abs(prod));
%         [minVal, index] = min(infNorm);
%         if minVal > maxVal
%             maxVal = minVal;
%             bestW = w;
%             bestX = X(:,index);
%         end
%     end
    w = bestW;
    x = bestX;
    l = maxVal;
end