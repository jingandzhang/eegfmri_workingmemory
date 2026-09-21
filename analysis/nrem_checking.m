
clear

load ss_info.mat

ss_list = glob('sub-*', preproc_dir);
ss_list = ss_list(~contains(ss_list,'html'));

Ns = length(ss_list);

cntr = 0;
dims = [];
ss_in = {}; ses_in = {};
for iss = 1:Ns
    
    ss = basename(ss_list{iss});
    ss_dir = [preproc_dir '/' ss '/'];
    ses_list = glob('ses*',ss_dir);

    for ises = 1:length(ses_list)
        
        nrem_dir = glob('spm_nrem_model1_test*', [ses_list{ises} '/']);
        
        if ~isempty(nrem_dir)
           
            spm_file = [nrem_dir{1} '/SPM.mat'];
            
            if exist(spm_file)
                load(spm_file)


                cntr = cntr+1;
                x = SPM.xX.X;
                dims(cntr,:) = [size(x,1) size(x,2)];
                ss_in{cntr} = ss;
                ses_in{cntr} = basename(ses_list{ises});
                disp('here')
                
                r(cntr,1) = corr(x(:,1),x(:,2));
                
                for isig =1:2
                   
                    xcr(:,cntr,isig) = xcorr(x(:,isig),20);
                    
                end
            end
            
        end
        
        
    end
    
end
%%
figure;plot(dims)

figure;plot(dims(:,2)./dims(:,1))


%%

for id = 1:size(xcr,2)
    for isig = 1:2
        
        d = xcr(:,id,isig);
%         xcr(:,id,isig) = d/max(d);
        
    end
end

figure;
clr = ['b','r'];
for isig = 1:2
    hold on;
    errorbar(mean(xcr(:,:,isig),2),std(xcr(:,:,isig),[],2)/sqrt(cntr),clr(isig))
end
