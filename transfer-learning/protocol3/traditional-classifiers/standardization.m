function [data,mu,sigma] = standardization(data_or)
ltkeo = data_or(:,1:256);
zc = data_or(:,257:512);
ssc = data_or(:,513:768);
skew = data_or(:,769:1024);
ltkeo_mean = mean(ltkeo(:));
zc_mean = mean(zc(:));
ssc_mean = mean(ssc(:));
skew_mean = mean(skew(:));
ltkeo_std = std(ltkeo(:));
zc_std = std(zc(:));
ssc_std = std(ssc(:));
skew_std = std(skew(:));

mu = [ltkeo_mean;zc_mean;ssc_mean;skew_mean];
sigma = [ltkeo_std;zc_std;ssc_std;skew_std];

ltkeo = (ltkeo - ltkeo_mean) / ltkeo_std;
zc = (zc - zc_mean) / zc_std;
ssc = (ssc - ssc_mean) / ssc_std;
skew = (skew - skew_mean) / skew_std;

data = [ltkeo,zc,ssc,skew];

