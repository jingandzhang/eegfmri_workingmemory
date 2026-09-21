function  tab=Generate_seq(L_seq,Eq,Let)
arrows={'→','←'};
ast='*';
Pre_Let={};



Equations={};
True_False={};
Letters={};

for i =1:L_seq
    if Eq
        [equ,TF]=generate_equ;
        Equations{i}=equ;
        True_False{i}=TF;
    else
        Equations{i}=arrows{randi(2)};
        True_False{i}=0;
    end
    
    if Let
        
        letters={'B','C','D','F','G','H','J','K','L','M','N','P','Q','R','S','T','V','W','Y','Z'};
        letters_ind=1:length(letters);
        
        for ii=1:length(Pre_Let)
            for j=1:length(letters_ind)
                if strcmp(Pre_Let{ii},letters{letters_ind(j)})
                    letters_ind(j)=[];
                    break
                end
                
            end
        end
        
        letters=letters(1,letters_ind);
        
        
        
        
        Letters{i}=letters{randi(length(letters))};
        Pre_Let{i}=Letters{i};
    else
        Letters{i}=ast;
    end
    tab=table(Equations',True_False',Letters','VariableNames',{'Equations','True_False','Letters'});
    
end

end

function [equ,TF]=generate_equ
TEMP=[-9 -8 -7 -6 -5 -4 -3 -2 -1 1 2 3 4 5 6 7 8 9 10];
result=100;
TF=randi(2)-1;
result_wrong=100;
while ~(result<=20 && result>=1)
    
    first_number=randi(10);
    second_number=randi(19);
    second_number=TEMP(second_number);
    if second_number>0
        operation='+';
    else
        operation='-';
    end
    second_number=abs(second_number);
    
    equ=[ num2str(first_number) operation num2str(second_number)];
    result=eval(equ);
    
    
    
    if TF
        equ=[equ '=' num2str(result)];
    else
        situ=randi(2);
        
        if situ==1
            equ=[equ '=' num2str(result+1)];
            result=result+1;
        else
            equ=[equ '=' num2str(result-1)];
            result=result-1;
        end
    end
    
    
end

end
