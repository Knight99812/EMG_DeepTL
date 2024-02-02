function myop_value = my_myop(sig)
% Parameter
thres = 0.016;    % threshold

% if isfield(opts,'thres'), thres = opts.thres; end

N = length(sig); 
Y = 0; 
for i = 1:N
  if abs(sig(i)) >= thres
    Y = Y + 1;
  end
end
myop_value = Y / N;
end

