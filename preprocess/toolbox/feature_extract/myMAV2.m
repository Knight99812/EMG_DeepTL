function MAV2feature=myMAV2(sig)

N=length(sig);
w=0;
MAV2feature=0;
for i=1:N
    if( (i>=0.25*N) && (i<=0.75*N) )
        w=1;
    else if (i<0.25*N)
            w=4*i/N;
        else
            w=4*(N-i)/N;
        end
    end
    MAV2feature=MAV2feature+w*abs(sig(i));
end
MAV2feature=MAV2feature/N;