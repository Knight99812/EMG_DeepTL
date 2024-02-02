function card_value=my_card(sig)
% Parameter
thres = 0.01;    % threshold

% if isfield(opts,'thres'), thres = opts.thres; end

N = length(sig);
% Sort data
Y = sort(sig);
Z = zeros(1, N-1);
for n = 1 : N - 1
  Z(n) = abs(Y(n) - Y(n+1)) > thres;
end
card_value = sum(Z);
end