n           = 7;
nTrial      = 10;
A           = naesatInstance(n);
disp(A);

for i=1:nTrial
    w        = rand(n,1);
    [val, x] = lindisc(A,w);
    [valr, xr, wr] = roundLindisc(A,w);
    disp([w, x, wr, x]);
    fprintf("lindisc(A,w): %.4f, lindisc(A, wr): %.4f.\n\n", val, valr);
end
fprintf("----------\n");

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
        if disc(S) > 0.50
            S(i, :) = zeros(1,n);
        end
    end
end

function [valr, xr, wr] = roundLindisc(A,w)
    n = size(A, 2);
    valr = 0;
    xr = zeros(n,1);
    testW = getW(n, w);
    nColW = size(testW,2);
    
    for i = 1:nColW
        test = testW(:,i);
        [testval, testx] = lindisc(A,test);
        if testval > valr
            valr = testval;
            wr = test;
            xr = testx;
        end
    end
end

function W = getW(n, w)
    ub = ceil(w*4)/4;
    lb = floor(w*4)/4;
    mask = dec2binmat(n);
    invmask = ~mask; 
    W = (ub .* mask) + (lb .* invmask);
    %disp([w,ub,lb]); disp(W);
end

function [val, varargout] = lindisc(A,w)
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

function value = disc(A)
    n = size(A, 2);
    center  = 0.5*ones(n,1);   % [center]_{nx1}
    value   = lindisc(A,center);
end

function X = dec2binmat(n)
    nCol = 2^n;                     % Number of string
    X = dec2bin(0:nCol-1) - '0';    % Each row is bin-digits of a number
    X = X';                         % Each col is '''
end

% n           = 5;
% nTrial      = 10;
% A           = naesatInstance(n);
% w           = rand(n,1);
% disp(A);
% 
% for i=1:n
%     w_up        = w;
%     w_down      = w;
%     w_up(i)     = ceil(w(i)*4)/4;
%     w_down(i)   = floor(w(i)*4)/4;
% 
%     [x, val]            = lindisc(A,w);
%     [x_up, val_up]      = lindisc(A,w_up);
%     [x_down, val_down]  = lindisc(A,w_down);
% 
%     disp([w,w_up,w_down]);
%     disp([x,x_up,x_down]);
%     fprintf("(%.4f, %.4f, %.4f)\n\n", val, val_up, val_down);
% end
% fprintf("----------\n");