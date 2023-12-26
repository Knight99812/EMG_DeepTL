function [feature,feature_smooth,feature_tensor,feature_smooth_tensor]=featureExtract(EMG,EMG_Raw,EMG_Rest,fs,windowTime,stepTime)

thresh_WAMP=0.05;
thresh_MYOP=0.1;
thresh_ZC=0.03;
thresh_SSC=0.03;
MAVS_seg_num=2;
HG_kmax=2^7;
AR_order=4;
CC_order=4;
AFB_Wf=32; % ms
MHW_windowNum=3;
MHW_overlap=0.3; %30% overlap
MTW_windowNum=3;
MTW_overlap=0.3; %30% overlap
FR_fl=[15,45];
FR_fh=[95,500];
PSR_n=20; % Hz 
MAX_filterOrder=6;
MAX_fco=5;

windowLen=floor(windowTime*fs);
stepLen=floor(stepTime*fs);
[Nchannel,Nsample]=size(EMG);

for i=1:53
    feature{1,i}=[];
    feature_smooth{1,i}=[];
    feature_tensor{1,i}=[];
    feature_smooth_tensor{1,i}=[];
end

for i=windowLen:stepLen:Nsample
    endIdx=i;
    beginIdx=endIdx-windowLen+1;
    
    featureIdx=1
    tmp=RMS_extract(EMG(:,beginIdx:endIdx));
    feature{1,1}=[feature{1,1},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,1}=[feature_smooth{1,1},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,1}=cat(1,feature_tensor{1,1},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,1}=cat(1,feature_smooth_tensor{1,1},tmp_smooth_tensor);
    
    featureIdx=2
    tmp=WL_extract(EMG(:,beginIdx:endIdx));
    feature{1,2}=[feature{1,2},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,2}=[feature_smooth{1,2},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,2}=cat(1,feature_tensor{1,2},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,2}=cat(1,feature_smooth_tensor{1,2},tmp_smooth_tensor);
    
    featureIdx=3
    tmp=samEntro_extract(EMG(:,beginIdx:endIdx));
    feature{1,3}=[feature{1,3},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,3}=[feature_smooth{1,3},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,3}=cat(1,feature_tensor{1,3},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,3}=cat(1,feature_smooth_tensor{1,3},tmp_smooth_tensor);
    
    featureIdx=4
    tmp=specEntro_extract(EMG(:,beginIdx:endIdx),fs);
    feature{1,4}=[feature{1,4},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,4}=[feature_smooth{1,4},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,4}=cat(1,feature_tensor{1,4},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,4}=cat(1,feature_smooth_tensor{1,4},tmp_smooth_tensor);
    
    featureIdx=5
    tmp=MDF_extract(EMG(:,beginIdx:endIdx),fs);
    feature{1,5}=[feature{1,5},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,5}=[feature_smooth{1,5},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,5}=cat(1,feature_tensor{1,5},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,5}=cat(1,feature_smooth_tensor{1,5},tmp_smooth_tensor);
    
    featureIdx=6
    tmp=MNF_extract(EMG(:,beginIdx:endIdx),fs);
    feature{1,6}=[feature{1,6},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,6}=[feature_smooth{1,6},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,6}=cat(1,feature_tensor{1,6},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,6}=cat(1,feature_smooth_tensor{1,6},tmp_smooth_tensor);
    
    featureIdx=7
    tmp=MNP_extract(EMG(:,beginIdx:endIdx),fs); % same as TTP
    feature{1,7}=[feature{1,7},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,7}=[feature_smooth{1,7},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,7}=cat(1,feature_tensor{1,7},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,7}=cat(1,feature_smooth_tensor{1,7},tmp_smooth_tensor);
    
    featureIdx=8
    tmp=ApEntro_extract(EMG(:,beginIdx:endIdx));
    feature{1,8}=[feature{1,8},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,8}=[feature_smooth{1,8},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,8}=cat(1,feature_tensor{1,8},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,8}=cat(1,feature_smooth_tensor{1,8},tmp_smooth_tensor);
    
    featureIdx=9
    tmp=AAC_extract(EMG(:,beginIdx:endIdx));
    feature{1,9}=[feature{1,9},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,9}=[feature_smooth{1,9},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,9}=cat(1,feature_tensor{1,9},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,9}=cat(1,feature_smooth_tensor{1,9},tmp_smooth_tensor);
    
    featureIdx=10
    tmp=DASDV_extract(EMG(:,beginIdx:endIdx));
    feature{1,10}=[feature{1,10},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,10}=[feature_smooth{1,10},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,10}=cat(1,feature_tensor{1,10},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,10}=cat(1,feature_smooth_tensor{1,10},tmp_smooth_tensor);
    
    featureIdx=11
    tmp=IAV_extract(EMG(:,beginIdx:endIdx));
    feature{1,11}=[feature{1,11},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,11}=[feature_smooth{1,11},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,11}=cat(1,feature_tensor{1,11},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,11}=cat(1,feature_smooth_tensor{1,11},tmp_smooth_tensor);
    
    featureIdx=12
    tmp=MAV_extract(EMG(:,beginIdx:endIdx)); % same as IEMG(:,beginIdx:endIdx)
    feature{1,12}=[feature{1,12},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,12}=[feature_smooth{1,12},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,12}=cat(1,feature_tensor{1,12},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,12}=cat(1,feature_smooth_tensor{1,12},tmp_smooth_tensor);
    
    featureIdx=13
    tmp=MAV1_extract(EMG(:,beginIdx:endIdx));
    feature{1,13}=[feature{1,13},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,13}=[feature_smooth{1,13},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,13}=cat(1,feature_tensor{1,13},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,13}=cat(1,feature_smooth_tensor{1,13},tmp_smooth_tensor);
    
    featureIdx=14
    tmp=MAV2_extract(EMG(:,beginIdx:endIdx));
    feature{1,14}=[feature{1,14},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,14}=[feature_smooth{1,14},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,14}=cat(1,feature_tensor{1,14},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,14}=cat(1,feature_smooth_tensor{1,14},tmp_smooth_tensor);
    
    featureIdx=15
    tmp=SSI_extract(EMG(:,beginIdx:endIdx));
    feature{1,15}=[feature{1,15},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,15}=[feature_smooth{1,15},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,15}=cat(1,feature_tensor{1,15},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,15}=cat(1,feature_smooth_tensor{1,15},tmp_smooth_tensor);
    
    featureIdx=16
    tmp=Hjorth1_VAR_extract(EMG(:,beginIdx:endIdx));
    feature{1,16}=[feature{1,16},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,16}=[feature_smooth{1,16},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,16}=cat(1,feature_tensor{1,16},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,16}=cat(1,feature_smooth_tensor{1,16},tmp_smooth_tensor);
    
    featureIdx=17
    tmp=Hjorth2_extract(EMG(:,beginIdx:endIdx));
    feature{1,17}=[feature{1,17},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,17}=[feature_smooth{1,17},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,17}=cat(1,feature_tensor{1,17},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,17}=cat(1,feature_smooth_tensor{1,17},tmp_smooth_tensor);
    
    featureIdx=18
    tmp=Hjorth3_extract(EMG(:,beginIdx:endIdx));
    feature{1,18}=[feature{1,18},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,18}=[feature_smooth{1,18},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,18}=cat(1,feature_tensor{1,18},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,18}=cat(1,feature_smooth_tensor{1,18},tmp_smooth_tensor);
    
    featureIdx=19
    tmp=AR_extract(EMG(:,beginIdx:endIdx),AR_order);
    feature{1,19}=[feature{1,19},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,19}=[feature_smooth{1,19},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,19}=cat(1,feature_tensor{1,19},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,19}=cat(1,feature_smooth_tensor{1,19},tmp_smooth_tensor);
    
    featureIdx=20
    tmp=WAMP_extract(EMG(:,beginIdx:endIdx),thresh_WAMP);
    feature{1,20}=[feature{1,20},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,20}=[feature_smooth{1,20},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,20}=cat(1,feature_tensor{1,20},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,20}=cat(1,feature_smooth_tensor{1,20},tmp_smooth_tensor);
    
    featureIdx=21
    tmp=MYOP_extract(EMG(:,beginIdx:endIdx),thresh_MYOP);
    feature{1,21}=[feature{1,21},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,21}=[feature_smooth{1,21},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,21}=cat(1,feature_tensor{1,21},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,21}=cat(1,feature_smooth_tensor{1,21},tmp_smooth_tensor);
    
    featureIdx=22
    tmp=ZC_extract(EMG(:,beginIdx:endIdx),EMG_Rest,thresh_ZC);
    feature{1,22}=[feature{1,22},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,22}=[feature_smooth{1,22},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,22}=cat(1,feature_tensor{1,22},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,22}=cat(1,feature_smooth_tensor{1,22},tmp_smooth_tensor);
    
    featureIdx=23
    tmp=SSC_extract(EMG(:,beginIdx:endIdx),EMG_Rest,thresh_SSC);
    feature{1,23}=[feature{1,23},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,23}=[feature_smooth{1,23},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,23}=cat(1,feature_tensor{1,23},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,23}=cat(1,feature_smooth_tensor{1,23},tmp_smooth_tensor);
    
    featureIdx=24
    tmp=MAVS_extract(EMG(:,beginIdx:endIdx),MAVS_seg_num);
    feature{1,24}=[feature{1,24},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,24}=[feature_smooth{1,24},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,24}=cat(1,feature_tensor{1,24},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,24}=cat(1,feature_smooth_tensor{1,24},tmp_smooth_tensor);
    
    featureIdx=25
    tmp=MFL_extract(EMG(:,beginIdx:endIdx));
    feature{1,25}=[feature{1,25},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,25}=[feature_smooth{1,25},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,25}=cat(1,feature_tensor{1,25},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,25}=cat(1,feature_smooth_tensor{1,25},tmp_smooth_tensor);
    
    featureIdx=26
    tmp=HG_extract(EMG(:,beginIdx:endIdx),HG_kmax);
    feature{1,26}=[feature{1,26},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,26}=[feature_smooth{1,26},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,26}=cat(1,feature_tensor{1,26},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,26}=cat(1,feature_smooth_tensor{1,26},tmp_smooth_tensor);
    
    featureIdx=27
    tmp=SKW_extract(EMG(:,beginIdx:endIdx));
    feature{1,27}=[feature{1,27},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,27}=[feature_smooth{1,27},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,27}=cat(1,feature_tensor{1,27},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,27}=cat(1,feature_smooth_tensor{1,27},tmp_smooth_tensor);
    
    featureIdx=28
    tmp=VFD_extract(EMG(:,beginIdx:endIdx));
    feature{1,28}=[feature{1,28},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,28}=[feature_smooth{1,28},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,28}=cat(1,feature_tensor{1,28},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,28}=cat(1,feature_smooth_tensor{1,28},tmp_smooth_tensor);
    
    featureIdx=29
    tmp=LogDetect_extract(EMG(:,beginIdx:endIdx));
    feature{1,29}=[feature{1,29},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,29}=[feature_smooth{1,29},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,29}=cat(1,feature_tensor{1,29},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,29}=cat(1,feature_smooth_tensor{1,29},tmp_smooth_tensor);
    
    featureIdx=30
    tmp=CC_extract(EMG(:,beginIdx:endIdx),CC_order);
    feature{1,30}=[feature{1,30},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,30}=[feature_smooth{1,30},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,30}=cat(1,feature_tensor{1,30},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,30}=cat(1,feature_smooth_tensor{1,30},tmp_smooth_tensor);
    
    featureIdx=31
    tmp=TM_extract(EMG(:,beginIdx:endIdx),3);
    feature{1,31}=[feature{1,31},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,31}=[feature_smooth{1,31},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,31}=cat(1,feature_tensor{1,31},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,31}=cat(1,feature_smooth_tensor{1,31},tmp_smooth_tensor);
    
    featureIdx=32
    tmp=TM_extract(EMG(:,beginIdx:endIdx),4);
    feature{1,32}=[feature{1,32},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,32}=[feature_smooth{1,32},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,32}=cat(1,feature_tensor{1,32},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,32}=cat(1,feature_smooth_tensor{1,32},tmp_smooth_tensor);
    
    featureIdx=33
    tmp=TM_extract(EMG(:,beginIdx:endIdx),5);
    feature{1,33}=[feature{1,33},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,33}=[feature_smooth{1,33},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,33}=cat(1,feature_tensor{1,33},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,33}=cat(1,feature_smooth_tensor{1,33},tmp_smooth_tensor);
    
    featureIdx=34
    tmp=TM_extract(EMG(:,beginIdx:endIdx),7);
    feature{1,34}=[feature{1,34},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,34}=[feature_smooth{1,34},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,34}=cat(1,feature_tensor{1,34},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,34}=cat(1,feature_smooth_tensor{1,34},tmp_smooth_tensor);
    
    featureIdx=35
    tmp=AFB_extract(EMG(:,beginIdx:endIdx),fs,AFB_Wf);
    feature{1,35}=[feature{1,35},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,35}=[feature_smooth{1,35},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,35}=cat(1,feature_tensor{1,35},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,35}=cat(1,feature_smooth_tensor{1,35},tmp_smooth_tensor);
    
    featureIdx=36
    tmp=V_extract(EMG(:,beginIdx:endIdx),3);
    feature{1,36}=[feature{1,36},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,36}=[feature_smooth{1,36},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,36}=cat(1,feature_tensor{1,36},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,36}=cat(1,feature_smooth_tensor{1,36},tmp_smooth_tensor);
    
    featureIdx=37
    tmp=Kurtosis_extract(EMG(:,beginIdx:endIdx));
    feature{1,37}=[feature{1,37},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,37}=[feature_smooth{1,37},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,37}=cat(1,feature_tensor{1,37},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,37}=cat(1,feature_smooth_tensor{1,37},tmp_smooth_tensor);
    
    featureIdx=38
    tmp=MHW_extract(EMG(:,beginIdx:endIdx),MHW_windowNum,MHW_overlap);
    feature{1,38}=[feature{1,38},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,38}=[feature_smooth{1,38},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,38}=cat(1,feature_tensor{1,38},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,38}=cat(1,feature_smooth_tensor{1,38},tmp_smooth_tensor);
    
    featureIdx=39
    tmp=MTW_extract(EMG(:,beginIdx:endIdx),MTW_windowNum,MTW_overlap);
    feature{1,39}=[feature{1,39},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,39}=[feature_smooth{1,39},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,39}=cat(1,feature_tensor{1,39},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,39}=cat(1,feature_smooth_tensor{1,39},tmp_smooth_tensor);
    
    featureIdx=40
    tmp=PKF_extract(EMG(:,beginIdx:endIdx),fs);
    feature{1,40}=[feature{1,40},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,40}=[feature_smooth{1,40},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,40}=cat(1,feature_tensor{1,40},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,40}=cat(1,feature_smooth_tensor{1,40},tmp_smooth_tensor);
    
    featureIdx=41
    tmp=PSDFD_extract(EMG(:,beginIdx:endIdx),fs);
    feature{1,41}=[feature{1,41},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,41}=[feature_smooth{1,41},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,41}=cat(1,feature_tensor{1,41},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,41}=cat(1,feature_smooth_tensor{1,41},tmp_smooth_tensor);
    
    featureIdx=42
    tmp=SM_extract(EMG(:,beginIdx:endIdx),fs,1);
    feature{1,42}=[feature{1,42},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,42}=[feature_smooth{1,42},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,42}=cat(1,feature_tensor{1,42},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,42}=cat(1,feature_smooth_tensor{1,42},tmp_smooth_tensor);
    
    featureIdx=43
    tmp=SM_extract(EMG(:,beginIdx:endIdx),fs,2);
    feature{1,43}=[feature{1,43},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,43}=[feature_smooth{1,43},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,43}=cat(1,feature_tensor{1,43},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,43}=cat(1,feature_smooth_tensor{1,43},tmp_smooth_tensor);
    
    featureIdx=44
    tmp=SM_extract(EMG(:,beginIdx:endIdx),fs,3);
    feature{1,44}=[feature{1,44},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,44}=[feature_smooth{1,44},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,44}=cat(1,feature_tensor{1,44},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,44}=cat(1,feature_smooth_tensor{1,44},tmp_smooth_tensor);
    
    featureIdx=45
    tmp=FR_extract(EMG(:,beginIdx:endIdx),fs,FR_fl,FR_fh);
    feature{1,45}=[feature{1,45},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,45}=[feature_smooth{1,45},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,45}=cat(1,feature_tensor{1,45},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,45}=cat(1,feature_smooth_tensor{1,45},tmp_smooth_tensor);
    
    featureIdx=46
    tmp=PSR_extract(EMG(:,beginIdx:endIdx),fs,PSR_n);
    feature{1,46}=[feature{1,46},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,46}=[feature_smooth{1,46},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,46}=cat(1,feature_tensor{1,46},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,46}=cat(1,feature_smooth_tensor{1,46},tmp_smooth_tensor);
    
    featureIdx=47
    tmp=VCF_extract(EMG(:,beginIdx:endIdx),fs);
    feature{1,47}=[feature{1,47},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,47}=[feature_smooth{1,47},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,47}=cat(1,feature_tensor{1,47},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,47}=cat(1,feature_smooth_tensor{1,47},tmp_smooth_tensor);
    
    featureIdx=48
    tmp=SNR_extract(EMG(:,beginIdx:endIdx),EMG_Rest);
    feature{1,48}=[feature{1,48},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,48}=[feature_smooth{1,48},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,48}=cat(1,feature_tensor{1,48},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,48}=cat(1,feature_smooth_tensor{1,48},tmp_smooth_tensor);
    
    featureIdx=49
    tmp=OHM_extract(EMG(:,beginIdx:endIdx),fs);
    feature{1,49}=[feature{1,49},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,49}=[feature_smooth{1,49},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,49}=cat(1,feature_tensor{1,49},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,49}=cat(1,feature_smooth_tensor{1,49},tmp_smooth_tensor);
    
    featureIdx=50
    tmp=MAX_extract(EMG_Raw(:,beginIdx:endIdx),fs,MAX_filterOrder,MAX_fco);
    feature{1,50}=[feature{1,50},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,50}=[feature_smooth{1,50},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,50}=cat(1,feature_tensor{1,50},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,50}=cat(1,feature_smooth_tensor{1,50},tmp_smooth_tensor);
    
    featureIdx=51
    tmp=SMR_extract(EMG_Raw(:,beginIdx:endIdx),fs);
    feature{1,51}=[feature{1,51},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,51}=[feature_smooth{1,51},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,51}=cat(1,feature_tensor{1,51},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,51}=cat(1,feature_smooth_tensor{1,51},tmp_smooth_tensor);
    
    featureIdx=52
    tmp=DPR_extract(EMG_Raw(:,beginIdx:endIdx),fs);
    feature{1,52}=[feature{1,52},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,52}=[feature_smooth{1,52},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,52}=cat(1,feature_tensor{1,52},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,52}=cat(1,feature_smooth_tensor{1,52},tmp_smooth_tensor);
    
    featureIdx=53
    tmp=Sync_extract(EMG(:,beginIdx:endIdx));
    feature{1,53}=[feature{1,53},tmp];
    tmp_smooth=myFeatureMapSmooth(tmp,length(tmp)/256);
    feature_smooth{1,53}=[feature_smooth{1,53},tmp_smooth];
    tmp_tensor=myFeatureTensor(tmp);
    feature_tensor{1,53}=cat(1,feature_tensor{1,53},tmp_tensor);
    tmp_smooth_tensor=myFeatureTensor(tmp_smooth);
    feature_smooth_tensor{1,53}=cat(1,feature_smooth_tensor{1,53},tmp_smooth_tensor);
    
end

