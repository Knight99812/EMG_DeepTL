function MAV1feature=myMAV1(sig)

N=length(sig);
w=0;
MAV1feature=0;
for i=1:N
    if( (i>=0.25*N) && (i<=0.75*N) )
        w=1;
    else
        w=0.5;
    end
    MAV1feature=MAV1feature+w*abs(sig(i));
end
MAV1feature=MAV1feature/N;