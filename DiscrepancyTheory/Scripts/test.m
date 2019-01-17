fprintf("[TEST] allZeroOneVectorsDim(n)...\n");
fprintf("---------> allZeroOneVectorsDim(3)\n");
disp(allZeroOneVectorsDim(3));
fprintf("---------> allZeroOneVectorsDim(4)\n");
disp(allZeroOneVectorsDim(4));
fprintf("[TEST END]\n");

fprintf("\n[TEST] allWeightVectorsDim(n, interval)...\n");
fprintf("---------> allWeightVectorsDim(3, 2)\n");
disp(allWeightVectorsDim(3,2));
fprintf("---------> allWeightVectorsDim(3, 3)\n");
disp(allWeightVectorsDim(3,3));
fprintf("[TEST END]\n");

fprintf("\n[SET-UP] Discrepancy function test\n");
powOf2 = [1,2,4,8,16];
fprintf("powOf2\n");
disp(powOf2);

sat4 = [
        1,1,1,0;
        1,1,0,1;
        1,0,1,1;
        0,1,1,1;
    ];
fprintf("sat4\n");
disp(sat4);

hadamard4 = [
        1,-1,-1, 1;
        1, 1,-1,-1;
        1,-1, 1,-1;
        1, 1, 1, 1;
    ];
fprintf("hadamard4\n");
disp(sat4);

fprintf("\n[TEST] lindisc(A, interval)...\n");
fprintf("---------> lindisc(powOf2, 2)  = %.4f\n", lindisc(powOf2, 2));
fprintf("---------> lindisc(sat4, 2)    = %.4f\n", lindisc(sat4, 2));
fprintf("---------> lindisc(sat4, 5)    = %.4f\n", lindisc(sat4, 5));
fprintf("[TEST END]\n");

fprintf("\n[TEST] disc(A)...\n");
fprintf("---------> disc(powOf2)    = %.4f\n", disc(powOf2));
fprintf("---------> disc(sat4)      = %.4f\n", disc(sat4));
fprintf("---------> disc(hadamard4) = %.4f\n", disc(hadamard4));
fprintf("[TEST END]\n");

fprintf("\n[TEST] lindiscApprox(A, ntrials)...\n");
fprintf("---------> lindiscApprox(powOf2, 100)      = %.4f\n", lindiscApprox(powOf2, 100));
fprintf("---------> lindiscApprox(sat4, 100)        = %.4f\n", lindiscApprox(sat4, 100));
fprintf("---------> lindiscApprox(hadamard4, 100)   = %.4f\n", lindiscApprox(hadamard4, 100));
fprintf("[TEST END]\n");

% Sample Test Block
% fprintf("[TEST] function(arg1, arg2)...\n");
% fprintf("---------> function(val1, val2)\n");
% disp(function(val1, val2));
% fprintf("[TEST END]\n");