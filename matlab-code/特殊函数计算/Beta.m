function BF = Beta(x,y)
format long;
BF = exp(gammaln(x)+gammaln(y)-gammaln(x+y));
