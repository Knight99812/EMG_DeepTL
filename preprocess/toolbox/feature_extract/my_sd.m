function sd_value=my_sd(sig)
N  = length(sig); 
mu = mean(sig); 
sd_value = sqrt((1 / (N - 1)) * sum((sig - mu) .^ 2));
end