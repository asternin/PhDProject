%Pieman Scoring
files=dir(['*','_TunnelUnderTheWorld_','*']);
ALLRESP=zeros(360,length(files));
ALLSCORES=zeros(4,length(files));
for f=1:length(files)
    load(files(f).name);
    corr_inhib=0;
    corr_resp=0;
    inc_inhib=0;
    inc_resp=0;
    
    % INHIBITION TRIALS
    inhib=find(data(:,1)==3);
    for i=1:length(inhib)
        if data(inhib(i),2) == 0
            corr_inhib=corr_inhib+1;
        else
            inc_inhib=inc_inhib+1;
        end
    end
    %check
    %corr_inhib+inc_inhib
    
    % RESPONSE TRIALS
    resp=find(data(:,1)~=3);
    for i=1:length(resp)
        if data(resp(i),2) == 1
            corr_resp=corr_resp+1;
        else
            inc_resp=inc_resp+1;
        end
    end
    % check
    %corr_resp+inc_resp
    
    % Create list of 0 and 1 for correct and incorrect for plotting
    RESP=zeros(length(data),1);
    for i=1:length(data)
        if data(i,1)==3
            if data(i,2)==0 %CORRECT
                RESP(i)=1;
            elseif data(i,2)==1 %INCORRECT
                RESP(i)=0;
            end
        elseif data(i,1)~=3
            if data(i,2)==1 %CORRECT
                RESP(i)=1;
            elseif data(i,2)==0 %INCORRECT
                RESP(i)=0;
            end
        end
    end
  ALLRESP(:,f)=RESP;
  ALLSCORES(1,f)=corr_inhib;
  ALLSCORES(2,f)=corr_resp;
  ALLSCORES(3,f)=inc_inhib;
  ALLSCORES(4,f)=inc_resp;
end
save('TunnelScores.mat','ALLRESP','ALLSCORES');