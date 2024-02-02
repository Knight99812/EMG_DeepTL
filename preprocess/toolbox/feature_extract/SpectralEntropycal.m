function [spectralEntropyfeature,spectralEntropymapfeature_reshape]=SpectralEntropycal(dataSeg)

[Nchannel,Nsample,pwdLen,Ntrial]=size(dataSeg);

fs=4000;

spectralEntropyfeature=zeros(Ntrial,Nchannel,pwdLen);
spectralEntropymapfeature_reshape=zeros(Ntrial,8,8,pwdLen);


for i=1:Ntrial
    parfor j=1:Nchannel
        for k=1:pwdLen
            i
            j
            k
            sig=squeeze(dataSeg(j,:,k,i));
            entro=pentropy(sig',fs,'Instantaneous',false);
            if(isnan(entro))
                entro=0;
            end
            spectralEntropyfeature(i,j,k)=entro;
        end
    end
end

for i=1:Ntrial
    for k=1:pwdLen
        tmp=spectralEntropyfeature(i,:,k);
        for u=1:8
            for v=1:8
                idx=Nchannel-((u-1)*8+v)+1;
                map(u,v)=tmp(idx);
            end
        end
        spectralEntropymapfeature_reshape(i,:,:,k)=map;
    end
end

for i=1:Ntrial
    for k=1:pwdLen
        map=squeeze(spectralEntropymapfeature_reshape(i,:,:,k));
        for u=1:8
            for v=1:8
                if(map(u,v)==0)
                    neighbor=[];
                    if(u==1)
                        if(v==1)
                            neighbor=[neighbor,map(u,v+1),map(u+1,v)];
                        else if (v==8)
                            neighbor=[neighbor,map(u,v-1),map(u+1,v)];
                            else
                                neighbor=[neighbor,map(u,v-1),map(u,v+1),map(u+1,v)];
                            end
                        end
                    end
                    if(u==8)
                        if(v==1)
                            neighbor=[neighbor,map(u,v+1),map(u-1,v)];
                        else if (v==8)
                            neighbor=[neighbor,map(u,v-1),map(u-1,v)];
                            else
                                neighbor=[neighbor,map(u,v-1),map(u,v+1),map(u-1,v)];
                            end
                        end
                    end
                    if(u>1&&u<8)
                        if(v==1)
                            neighbor=[neighbor,map(u,v+1),map(u-1,v),map(u+1,v)];
                        else if (v==8)
                            neighbor=[neighbor,map(u,v-1),map(u-1,v),map(u+1,v)];
                            else
                                neighbor=[neighbor,map(u,v-1),map(u,v+1),map(u-1,v),map(u++1,v)];
                            end
                        end
                    end
                    zeroIdx=find(neighbor==0);
                    neighbor(zeroIdx)=[];
                    map(u,v)=mean(neighbor);
                end
                spectralEntropymapfeature_reshape(i,u,v,k)=map(u,v);
                idx=Nchannel-((u-1)*8+v)+1;
                spectralEntropyfeature(i,idx,k)=map(u,v);
            end
        end
    end
end

% for i=1:Ntrial
%     for k=1:pwdLen
%         meanV=mean(RMSfeature(i,:,k));
%         stdV=std(RMSfeature(i,:,k));
%         RMSmapfeature_reshape(i,:,:,k)=(RMSmapfeature_reshape(i,:,:,k)-meanV)/stdV;
%         RMSfeature(i,:,k)=(RMSfeature(i,:,k)-meanV)/stdV;
%     end
% end
                            


% finger=8;
% figure(1)
% imagesc(squeeze(RMSmapfeature_reshape(1,:,:,finger)));
% figure(2)
% imagesc(squeeze(RMSmapfeature_reshape(2,:,:,finger)));
% figure(3)
% imagesc(squeeze(RMSmapfeature_reshape(3,:,:,finger)));
% figure(4)
% imagesc(squeeze(RMSmapfeature_reshape(4,:,:,finger)));
% figure(5)
% imagesc(squeeze(RMSmapfeature_reshape(5,:,:,finger)));
%                 