A4 = [
        1,1,1,0;
        1,1,0,1;
        1,0,1,1;
        0,1,1,1;      
    ];
A5 = [
        1,1,1,0,0;
        1,1,0,1,0;
        1,0,1,1,0;
        0,0,1,1,1;
        0,1,1,0,1;
        0,1,0,1,1;
        1,1,0,0,1;
        1,0,1,0,1;
        1,0,0,1,1
    ];
% 0,1,1,1,0;
sat = [
    1,1,1,0,0,0;
    1,1,0,1,0,0;
    1,1,0,0,1,0;
    1,0,1,1,0,0;
    1,0,1,0,1,0;
    1,0,0,1,1,0;    
    0,1,1,0,0,1;
    0,1,0,1,0,1;
    0,1,0,0,1,1;
    0,0,1,1,0,1;
    0,0,1,0,1,1;
    0,0,0,1,1,1;   
    1,1,0,0,0,1;
    1,0,1,0,0,1;
    1,0,0,1,0,1;
    1,0,0,0,1,1;
];
A6 = [
        1,1,1,0,0,0;
        1,1,0,1,0,0;
        1,0,1,1,0,0;
        0,1,1,1,0,0;
        1,1,0,0,1,0;
        1,0,1,0,1,0;
        1,0,0,1,1,0;
        0,1,1,0,1,0;
        0,1,0,1,1,0;
        0,0,1,1,1,0;
        1,1,0,0,0,1;
        1,0,1,0,0,1;
        1,0,0,1,0,1;
        1,0,0,0,1,1;
        0,1,1,0,0,1;
        0,1,0,1,0,1;
        0,1,0,0,1,1;
        0,0,1,1,0,1;
        0,0,1,0,1,1;
      ];
%        0,0,0,1,1,1

A7 = [
        1,1,0,0,1,0,0;
        1,0,1,0,1,0,0;
        1,0,0,1,1,0,0;
        0,1,1,0,1,0,0;
        0,1,0,1,1,0,0;
        0,0,1,1,1,0,0;
        1,1,0,0,0,1,0;
        1,0,1,0,0,1,0;
        1,0,0,1,0,1,0;
        1,0,0,0,1,1,0;
        0,1,1,0,0,1,0;
        0,1,0,1,0,1,0;
        0,1,0,0,1,1,0;
        0,0,1,1,0,1,0;
        0,0,1,0,1,1,0;
        0,0,0,1,1,1,0;
        1,1,0,0,0,0,1;
        1,0,1,0,0,0,1;
        1,0,0,1,0,0,1;
        1,0,0,0,1,0,1;
        1,0,0,0,0,1,1;
        0,1,1,0,0,0,1;
        0,1,0,1,0,0,1;
        0,1,0,0,1,0,1;
        0,1,0,0,0,1,1;
        0,0,1,1,0,0,1;
        0,0,1,0,1,0,1;
        0,0,1,0,0,1,1;
        0,0,0,1,1,0,1;
        0,0,0,1,0,1,1;
      ];
%         0,0,0,0,1,1,1;
%         1,1,1,0,0,0,0;
%         1,1,0,1,0,0,0;
%         1,0,1,1,0,0,0;
%         0,1,1,1,0,0,0;

val = lindisc(sat);
fprintf("lindisc(A): %.4f.\n\n", val);

%[valhalf,x] = lindiscvec(A7, ones(7,1)/2);
%fprintf("lindisc(A,ones(7,1)/2): %.4f.\n", valhalf);
%disp(x);

function val = lindisc(A)
    count = 0;
    n = size(A,2);
    nColor = 2^n;
    X = dec2binmat(n);              % [X]_{nx2^n} 
    allW = getW(n);
    nW = size(allW, 2);   
    val = 0;
    
    for i=1:nW
        w = allW(:,i);
        W = repmat(w,1,nColor);     % [W]_{nx2^n}
        tmpval = min(max(abs(A*(X-W))));
        if tmpval > val
            val = tmpval;
        end
    end
    
    if val >= 1.2
        for i=1:nW
            w = allW(:,i);
            W = repmat(w,1,nColor);     % [W]_{nx2^n}
            rowsum = max(abs(A*(X-W)));
            if count < 100 && min(rowsum) == val
                count = count + 1;
                fprintf("---------------------\n");
                fprintf("[%d] w:\n", count);
                disp(w);
                fprintf("x:\n");
                disp(X(:, rowsum == val));
            end
        end
    end
end

function W = getW(n)
    %wVal = [0, 1/6, 2/6, 3/6, 4/6, 5/6, 1];
    wVal = [0, 1/8, 1/4, 3/8, 1/2, 5/8, 3/4, 7/8, 1];
    %wVal = [0, 1/4, 1/2, 3/4, 1];
    lenW = length(wVal);
    W = zeros(n, lenW^n);
    for i = 1:n
        row = repelem(wVal, lenW^(i-1));
        rep = repmat(row, 1, lenW^(n-i))';
        W(i,:) = rep;
    end
end

function X = dec2binmat(n)
    nCol = 2^n;                     % Number of string
    X = dec2bin(0:nCol-1) - '0';    % Each row is bin-digits of a number
    X = X';                         % Each col is '''
end

function [val, varargout] = lindiscvec(A,w)
    n = size(A, 2);
    nColor = 2^n;
    X = dec2binmat(n);              % [X]_{nx2^n}      
    W = repmat(w,1,nColor);         % [W]_{nx2^n}
    
    [val, index] = min(max(abs(A*(W-X))));
    if nargout > 1
        varargout = cell(1);
        varargout{1} = X(:,index);
    end
end