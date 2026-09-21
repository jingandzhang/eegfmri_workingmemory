
function [starts,ends]=HN_EEG_burst(filtered_Signal,Fs,ignore_cycle,std_tr,band,max_cycles_befor_after,min_cycles_tostart,min_cycles,power_damp_ratio_befor_after)
% defult values for sigma
% ignore_cycle=1;
% std_tr=2;
% band=[12 16];
% max_cycles_befor_after=10;
% min_cycles_tostart=2;
% min_cycles=5;
% power_damp_ratio_befor_after=.5;


% defult values for SO
% ignore_cycle=0;
% std_tr=2;
% band=[.7 1.4];
% max_cycles_befor_after=10;
% min_cycles_tostart=0;
% min_cycles=1;
% power_damp_ratio_befor_after=.5;


filtered_Signal = hilbert(filtered_Signal);
Pha=angle(filtered_Signal);
Amp=abs(filtered_Signal);
ignore_cycle=ignore_cycle+1;
window_time=min_cycles*20/mean(band);
window_time=floor(window_time*Fs);
M=smooth(Amp,window_time);
S=(Amp-M').^2;
S=sqrt(smooth(S,window_time));
TR=(M+std_tr.*S)';
Amp_tred=Amp>TR;

% for i=ceil(window_time/2):(length(Amp)-ceil(window_time/2))
%     S(i)=std(Amp(i-floor(window_time/2)+1: i+floor(window_time/2)));
% end

starts=find(Amp_tred(2:end)-Amp_tred(1:end-1)==1)+1;
ends=find(Amp_tred(1:end-1)-Amp_tred(2:end)==1);

if (starts(1)>ends(1))
    starts=starts(2:end);
end
starts=starts(1:min(length(starts),length(ends)));
ends=ends(1:min(length(starts),length(ends)));

% cheking for min cycle to start
inds=zeros(1,length(starts));
for i =1:length(starts)
    temp_pha=Pha(starts(i):ends(i));
    M=temp_pha(1:end-1).*temp_pha(2:end);
    N_pi_to_npi=sum(M<0&(M<-8));
    N_ZX=sum(M<0&(M>-.1));
    N_cycle=min(N_pi_to_npi,N_ZX);
    if N_cycle>=min_cycles_tostart
        inds(i)=1;
    end
end
starts=starts(logical(inds));
ends=ends(logical(inds));
new_TR=zeros(1,length(starts));
for i=1:length(starts)
    new_TR(i)=mean(TR(starts(i):ends(i)));
end

% expanding
for i =1:length(starts)
    check_start=0;
    check_end=0;

    tmp_ZX1=0;

    tmp_ZX2=0;

    for C=1:max_cycles_befor_after

        if check_start<ignore_cycle && starts(i)>floor(Fs/band(1))
            new_start=starts(i)-floor(Fs/band(1));
            M=Pha(new_start:starts(i)-1).*Pha(new_start+1:starts(i));
            ZX=find(M<=0&(M>-.1));


            if ~isempty(ZX) && Amp(new_start+ZX(end))>power_damp_ratio_befor_after*new_TR(i)
                starts(i)=new_start+ZX(end)-1;
                check_start=0;
                tmp_ZX1=0;
            elseif ~isempty(ZX)
                check_start=check_start+1;
                temp=starts(i);
                starts(i)=new_start+ZX(end)-1;
                tmp_ZX1=tmp_ZX1+temp-starts(i);
            else
                check_start=ignore_cycle;
            end
        end



        if check_end<ignore_cycle && ends(i)+floor(Fs/band(1))<length(Amp)
            new_end=ends(i)+floor(Fs/band(1));
            M=Pha(ends(i):new_end-1).*Pha(ends(i)+1:new_end);
            ZX=find(M<=0&(M>-.1));

            if ~isempty(ZX) && Amp(ends(i)+ZX(end))>power_damp_ratio_befor_after*new_TR(i)
                ends(i)=ends(i)+ZX(end)+1;
                check_end=0;
                tmp_ZX2=0;
            elseif ~isempty(ZX)
                check_end=check_end+1;
                ends(i)=ends(i)+ZX(end)+1;
                tmp_ZX2=tmp_ZX2+ZX(end)+1;
            else
                check_end=ignore_cycle;
            end
        end


    end
    if check_start~=0
        starts(i)=starts(i)+tmp_ZX1;
    end
    if check_end~=0
        ends(i)=ends(i)-tmp_ZX2;
    end
end

check=true;
while (check)
    for i=1:length(starts)-1
        if (starts(i+1)<ends(i))
            ends(i)=ends(i+1);
            starts(i+1)=[];
            ends(i+1)=[];

            break
        end

    end

    if i==length(starts)-1
        check=false;
    end

end



% cheking for min cycle to end
inds=zeros(1,length(starts));
for i =1:length(starts)
    temp_pha=Pha(starts(i):ends(i));
    M=temp_pha(1:end-1).*temp_pha(2:end);
    N_pi_to_npi=sum(M<0&(M<-8));
    N_ZX=sum(M<0&(M>-.1));
    N_cycle=min(N_pi_to_npi,N_ZX);
    if N_cycle>=min_cycles
        inds(i)=1;
    end
end
starts=starts(logical(inds));
ends=ends(logical(inds));




end




