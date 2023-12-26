function MYOPfeature=myMYOP(sig,thresh)

N=length(sig);

MYOPfeature=0;
for i=1:N
    if(sig(i)>thresh)
        MYOPfeature=MYOPfeature+1;
    end
end
MYOPfeature=MYOPfeature/N;