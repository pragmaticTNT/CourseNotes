sat6 = [
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

% % ===> Mesh of weights <===
% for i=4:4
%     [val, w, x] = lindisc(sat6, i);
%     fprintf("lindisc(sat6, %d) = %.4f\n", i, val);
%     disp([w, x, w - x]);
% end
% 
% % ===> Random weights <===
% ntrials = 1000;
% [val, w, x] = lindiscApprox(sat6, ntrials);
% fprintf("lindiscApprox(sat6, %d) = %.4f\n", ntrials, val);
% disp([w, x, w-x]);

w = [
  0.98;
  0.63;
  0.47;
  0.63;
  0.47;
  0.63;
];
[val, x] = lindiscWRTw(sat6, w);
fprintf("lindiscWRTw(sat6, w) = %.4f\n", val);
disp([w, x, w - x]);