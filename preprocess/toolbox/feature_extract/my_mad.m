function mad_value=my_mad(sig)
N   = length(sig);
% Mean value
mu  = mean(sig);
% Mean absolute deviation 
mad_value = (1 / N) * sum(abs(sig - mu));
end