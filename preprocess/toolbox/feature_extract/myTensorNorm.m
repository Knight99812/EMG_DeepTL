function [tensorTrainNorm,tensorTestNorm]=myTensorNorm(tensorTrain,tensorTest)

if(length(size((tensorTrain)))==5)
    for i=1:size(tensorTrain,1)
        for j=1:size(tensorTrain,2)
            for u=1:size(tensorTrain,3)
                for v=1:size(tensorTrain,4)
                    tmp=squeeze(tensorTrain(i,j,u,v,:));
                    meanV=mean(tmp);
                    stdV=std(tmp);
                    if(stdV==0)
                        tensorTrainNorm(i,j,u,v,:)=(squeeze(tensorTrain(i,j,u,v,:))-meanV);
                        tensorTestNorm(i,j,u,v,:)=(squeeze(tensorTest(i,j,u,v,:))-meanV);
                    else
                        tensorTrainNorm(i,j,u,v,:)=(squeeze(tensorTrain(i,j,u,v,:))-meanV)/stdV;
                        tensorTestNorm(i,j,u,v,:)=(squeeze(tensorTest(i,j,u,v,:))-meanV)/stdV;
                    end
                end
            end
        end
    end
else
    tensorTrainNorm=[];
    tensorTestNorm=[];
end