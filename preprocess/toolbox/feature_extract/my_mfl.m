function mfl_value=my_mfl(sig)
N = length(sig);
Y = 0;
for n = 1 : N - 1
  Y = Y + (sig(n+1) - sig(n)) ^ 2;
end
mfl_value = log10(sqrt(Y));
end