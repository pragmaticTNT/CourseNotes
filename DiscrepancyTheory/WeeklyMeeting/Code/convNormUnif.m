clear;

#=================================================
#===> Setup 
#=================================================
step = 0.1;
maxInd = 4;
nRange = 0:step:maxInd;
results = zeros(length(nRange), maxInd);

#=================================================
#===> Generate Data
#=================================================
for i = 1:maxInd
  n = i*10;
  nRange = 0:step:n;

  mu = (n-1)/2;
  sigma = sqrt((n-1)/12);
  N = normpdf(nRange, mu, sigma);

  fixRange = nRange - 1;
  U = unidpdf(fixRange, n+1);

  h = conv(N, U, "full");
  results(1:length(0:step:2*n), i) =  h;

endfor

#=================================================
#===> Plot Data
#=================================================
figure();
plot(0:step:2*maxInd*10, results);
xlabel("n");
ylabel("probability");
title("Convolution of Normal and Uniform Function");
print("180202_1.pdf", "-dpdflatexstandalone");
system ("pdflatex 180202_1");
open ("180202_1.pdf");