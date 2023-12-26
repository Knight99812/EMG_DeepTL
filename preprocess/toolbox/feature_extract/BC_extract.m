function BC_feature=BC_extract(EMG,BC_ylim)

Nchannel=size(EMG,1);

BC_feature=zeros(1,Nchannel);

for i=1:Nchannel  
    i
    plot(EMG(i,:));
    ylim([-BC_ylim,BC_ylim]);
    xlim([-100,2663+100]);
    saveas(gcf,'EMGplot.jpg');
    close all;
    EMGplot=imread('EMGplot.jpg');
    EMGplot=rgb2gray(EMGplot);
    EMGplot=EMGplot(64:571,137:772);
    EMGplot=double(EMGplot<220);
    
    [n,r]=boxcount(EMGplot);
    x=log10(r);
    y=log10(n);
    a=polyfit(x,y,1);
    BC_feature(i)=-a(1);
end