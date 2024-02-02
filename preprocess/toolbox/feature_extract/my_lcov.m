function lcov_value=my_lcov(sig)
mu   = mean(sig); 
sd   = std(sig);
lcov_value = log(sd / mu);
end