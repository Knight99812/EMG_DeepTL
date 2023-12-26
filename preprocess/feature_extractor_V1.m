clear all;
close all;
clc;

path_data = 'F:\Data\V1\';
save_path = 'E:\EMG_DeepTL\data\V1\feature_all\';
index = [6,7,8,9,10,11,30,31,32,34];    % 选择的10种手势
window_len = 0.75; 
step_len = 0.75;
zc_ssc_thresh = 0.0004; 
fs_emg = 2048;
Nsample = ceil(window_len*fs_emg);
subjectID = {'01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20'};

for i = 1:20
    for j = 1:2
        load([path_data,subjectID{i},'_session',num2str(j),'\preprocessed_dynamic.mat']);
        load([path_data,subjectID{i},'_session',num2str(j),'\label_dynamic.mat']);
        s_index = find(ismember(label_dynamic,index)==1);
        data = preprocessed_dynamic(:,s_index);
        label = label_dynamic(:,s_index)';
        Ntrial=length(data);
        feature=[];
        
        for k = 1:Ntrial
            emg=data{1,k}(end-Nsample+1:end,:);
            mfl_tmp=get_mfl(emg,window_len,step_len,fs_emg);
            mfl=reshape(mfl_tmp,[1,numel(mfl_tmp)]);
            wa_tmp=get_wa(emg,window_len,step_len,fs_emg);
            wa=reshape(wa_tmp,[1,numel(wa_tmp)]);
            vare_tmp=get_vare(emg,window_len,step_len,fs_emg);
            vare=reshape(vare_tmp,[1,numel(vare_tmp)]);
            ssi_tmp=get_ssi(emg,window_len,step_len,fs_emg);
            ssi=reshape(ssi_tmp,[1,numel(ssi_tmp)]);
            myop_tmp=get_myop(emg,window_len,step_len,fs_emg);
            myop=reshape(myop_tmp,[1,numel(myop_tmp)]);
            mmav2_tmp=get_mmav2(emg,window_len,step_len,fs_emg);
            mmav2=reshape(mmav2_tmp,[1,numel(mmav2_tmp)]);
            mmav_tmp=get_mmav(emg,window_len,step_len,fs_emg);
            mmav=reshape(mmav_tmp,[1,numel(mmav_tmp)]);
            ld_tmp=get_ld(emg,window_len,step_len,fs_emg);
            ld=reshape(ld_tmp,[1,numel(ld_tmp)]);
            dasdv_tmp=get_dasdv(emg,window_len,step_len,fs_emg);
            dasdv=reshape(dasdv_tmp,[1,numel(dasdv_tmp)]);
            aac_tmp=get_aac(emg,window_len,step_len,fs_emg);
            aac=reshape(aac_tmp,[1,numel(aac_tmp)]);
            rms_tmp=get_rms(emg,window_len,step_len,fs_emg);
            rms=reshape(rms_tmp,[1,numel(rms_tmp)]);
            wl_tmp=get_wl(emg,window_len,step_len,fs_emg);
            wl=reshape(wl_tmp,[1,numel(wl_tmp)]);
            zc_tmp=get_zc(emg,window_len,step_len,zc_ssc_thresh,fs_emg);
            zc=reshape(zc_tmp,[1,numel(zc_tmp)]);
            ssc_tmp=get_ssc(emg,window_len,step_len,zc_ssc_thresh,fs_emg);
            ssc=reshape(ssc_tmp,[1,numel(ssc_tmp)]);
            mav_tmp=get_mav(emg,window_len,step_len,fs_emg);
            mav=reshape(mav_tmp,[1,numel(mav_tmp)]);
            iemg_tmp=get_iemg(emg,window_len,step_len,fs_emg);
            iemg=reshape(iemg_tmp,[1,numel(iemg_tmp)]);
            ae_tmp=get_ae(emg,window_len,step_len,fs_emg);
            ae=reshape(ae_tmp,[1,numel(ae_tmp)]);
            var_tmp=get_var(emg,window_len,step_len,fs_emg);
            var=reshape(var_tmp,[1,numel(var_tmp)]);
            sd_tmp=get_sd(emg,window_len,step_len,fs_emg);
            sd=reshape(sd_tmp,[1,numel(sd_tmp)]);
            cov_tmp=get_cov(emg,window_len,step_len,fs_emg);
            cov=reshape(cov_tmp,[1,numel(cov_tmp)]);
            kurt_tmp=get_kurt(emg,window_len,step_len,fs_emg);
            kurt=reshape(kurt_tmp,[1,numel(kurt_tmp)]);
            skew_tmp=get_skew(emg,window_len,step_len,fs_emg);
            skew=reshape(skew_tmp,[1,numel(skew_tmp)]);
            iqr_tmp=get_iqr(emg,window_len,step_len,fs_emg);
            iqr=reshape(iqr_tmp,[1,numel(iqr_tmp)]);
            mad_tmp=get_mad(emg,window_len,step_len,fs_emg);
            mad=reshape(mad_tmp,[1,numel(mad_tmp)]);
            ar_tmp=get_ar(emg,window_len,step_len,fs_emg);
            ar=reshape(ar_tmp,[1,numel(ar_tmp)]);
            damv_tmp=get_damv(emg,window_len,step_len,fs_emg);
            damv=reshape(damv_tmp,[1,numel(damv_tmp)]);
            tm_tmp=get_tm(emg,window_len,step_len,fs_emg);
            tm=reshape(tm_tmp,[1,numel(tm_tmp)]);
            vo_tmp=get_vo(emg,window_len,step_len,fs_emg);
            vo=reshape(vo_tmp,[1,numel(vo_tmp)]);
            dvarv_tmp=get_dvarv(emg,window_len,step_len,fs_emg);
            dvarv=reshape(dvarv_tmp,[1,numel(dvarv_tmp)]);
            ldamv_tmp=get_ldamv(emg,window_len,step_len,fs_emg);
            ldamv=reshape(ldamv_tmp,[1,numel(ldamv_tmp)]);
            ldasdv_tmp=get_ldasdv(emg,window_len,step_len,fs_emg);
            ldasdv=reshape(ldasdv_tmp,[1,numel(ldasdv_tmp)]);
            card_tmp=get_card(emg,window_len,step_len,fs_emg);
            card=reshape(card_tmp,[1,numel(card_tmp)]);
            lcov_tmp=get_lcov(emg,window_len,step_len,fs_emg);
            lcov=reshape(lcov_tmp,[1,numel(lcov_tmp)]);
            ltkeo_tmp=get_ltkeo(emg,window_len,step_len,fs_emg);
            ltkeo=reshape(ltkeo_tmp,[1,numel(ltkeo_tmp)]);
            msr_tmp=get_msr(emg,window_len,step_len,fs_emg);
            msr=reshape(msr_tmp,[1,numel(msr_tmp)]);
            ass_tmp=get_ass(emg,window_len,step_len,fs_emg);
            ass=reshape(ass_tmp,[1,numel(ass_tmp)]);
            asm_tmp=get_asm(emg,window_len,step_len,fs_emg);
            asm=reshape(asm_tmp,[1,numel(asm_tmp)]);
            fzc_tmp=get_fzc(emg,window_len,step_len,fs_emg);
            fzc=reshape(fzc_tmp,[1,numel(fzc_tmp)]);
            ewl_tmp=get_ewl(emg,window_len,step_len,fs_emg);
            ewl=reshape(ewl_tmp,[1,numel(ewl_tmp)]);
            emav_tmp=get_emav(emg,window_len,step_len,fs_emg);
            emav=reshape(emav_tmp,[1,numel(emav_tmp)]);
            
            feature(:,k)=[mfl';wa';vare';ssi';myop';
                mmav2';mmav';ld';dasdv';aac';
                rms';wl';zc';ssc';mav';
                iemg';ae';var';sd';cov';
                kurt';skew';iqr';mad';damv';
                tm';vo';dvarv';ldamv';ldasdv';
                card';lcov';ltkeo';msr';ass';
                asm';fzc';ewl';emav';ar';
                ];
        end
        feature = real(feature);
        save([save_path,num2str(i),'_',num2str(j),'.mat'],'feature');
    end
end
           