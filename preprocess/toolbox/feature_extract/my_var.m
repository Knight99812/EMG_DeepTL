function var_value=my_var(sig)
N   = length(sig); 
mu  = mean(sig);
var_value = (1 / (N - 1)) * sum((sig - mu) .^ 2);
end