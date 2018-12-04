%read in data
%6=DT, 7=OOO, 8=SP
%9=GR,10=DS, 11=TS
%12=PA, 13=SS, 14=FM
%15=R, 16=P, 17=ML
tasks={'DT','OOO','SP','GR','DS','TS','PA','SS','FM','R','P','ML'};
alldata=xlsread('Analysis/DataforR.xlsx');
%create categories based on MoCA scores
c=size(alldata,2);
for i=1:size(alldata,1)
    if alldata(i,4) >= 26
        alldata(i,c+1)=3; %unimpaired
    elseif alldata(i,4)<26 && alldata(i,4)>22
        alldata(i,c+1)=2; %borderline
    elseif alldata(i,4)<= 22
        alldata(i,c+1)=1; %impaired
    end
end
%remove participant with NaNs
alldata(20,:)=[];
%get indices for three groups
un=find(alldata(:,c+1)==3);
bo=find(alldata(:,c+1)==2);
im=find(alldata(:,c+1)==1);
%delete everything except task scores
data=alldata(:,6:17);
% %%
sprintf('CATEGORIZING JUST BORDERLINE PARTICIPANTS')
for t=3;%1:12
    %Calculate means of CBS tasks for group 1 and group 3
    un_mean=nanmean(data(un,t));
    im_mean=nanmean(data(im,t));
    new_un=0;
    new_bo=0;
    new_im=0;
    %resort borderline
    for i=1:size(bo,1)
        if data(bo(i),t) >= un_mean
            new_un=new_un+1; %unimpaired
        elseif data(bo(i),t) < un_mean && data(bo(i),t) > im_mean
            new_bo=new_bo+1; %borderline
        elseif data(bo(i),t)<= im_mean
            new_im=new_im+1; %impaired
        end
    end
    u=(new_un/length(bo)*100);
    i=(new_im/length(bo)*100);
    b=(new_bo/length(bo)*100);
    task=tasks{t};
    sprintf('For task %s: %.1f%% of people were moved to unimpaired, %.1f%% were moved to impaired, %.1f%% remained in borderline',...
        task,u,i,b)
end
% %%
% sprintf('CATEGORIZING ALL PARTICIPANTS BASED ON MEANS OF UNIMPAIRED AND IMPAIRED')
% for t=1:12
%     %Calculate means of CBS tasks for group 1 and group 3
%     un_mean=nanmean(data(un,t));
%     im_mean=nanmean(data(im,t));
%     new_un=0;
%     new_bo=0;
%     new_im=0;
%     %resort borderline
%     for i=1:size(data,1);
%         if data(i,t) >= un_mean;
%             new_un=new_un+1; %unimpaired
%         elseif data(i,t) < un_mean && data(i,t) > im_mean;
%             new_bo=new_bo+1; %borderline
%         elseif data(i,t)<= im_mean;
%             new_im=new_im+1; %impaired
%         end
%     end
%     u=(new_un/length(data)*100);
%     i=(new_im/length(data)*100);
%     b=(new_bo/length(data)*100);
%     task=tasks{t};
%     sprintf('For task %s: %.1f%% of people = unimpaired, %.1f%% = impaired, %.1f%% = borderline',...
%         task,u,i,b)
% end
%% Resorting borderline for all possible combinations of tests
sprintf('all combos')
un_mean=[];
im_mean=[];
results=struct('task',{},'u',[],'i',[],'b',[]); 
for c=1:12
    combos = nchoosek(1:12,c);
    for t=1:size(combos,1) %number of possible combinations      
        for r=1:size(combos,2) %number of tasks in that combo
            %Calculate and store means of CBS tasks for each group in this combo
            un_mean(t,r)=nanmean(data(un,combos(t,r)));
            im_mean(t,r)=nanmean(data(im,combos(t,r)));
        end
        new_un=0;
        new_bo=0;
        new_im=0;
        %resort borderline ONLY IF ALL TASKS AGREE
        for i=1:size(bo,1)
            un_count=0;
            im_count=0;
            for r=1:size(combos,2)
                if data(bo(i),combos(t,r)) >= un_mean(t,r)
                    un_count=un_count+1;
                end
                if data(bo(i),combos(t,r)) <= im_mean(t,r)
                    im_count=im_count+1;
                end
            end  
            %IF THEY ALL AGREE TO MOVE TO UNIMPAIRED
            if un_count==size(combos,2)
                new_un=new_un+1; %unimpaired
            %IF THEY ALL AGREE TO MOVE TO UNIMPAIRED
            elseif im_count==size(combos,2)
                new_im=new_im+1; %impaired
            else
                new_bo=new_bo+1; %borderline
            end
        end
        u=new_un;%(new_un/length(bo)*100);
        i=new_im;%(new_im/length(bo)*100);
        b=new_bo;%(new_bo/length(bo)*100);
        task=combos(t,:);
        results(end+1)=struct('task',{task},'u',u,'i',i,'b',b);
        %sprintf('For task %d: %d people were moved to unimpaired, %d were moved to impaired, %d remained in borderline', task,u,i,b)
    end
end
save('borderline_resort_results.mat','results');

tmp=struct2cell(results);
tmp=squeeze(tmp)';
tmp=cell2mat(tmp(:,4));
s=find(tmp==min(tmp));
results(s)
%% Resorting all data for all possible combinations of tests
sprintf('all combos')
un_mean=[];
im_mean=[];
results=struct('task',{},'u',[],'i',[],'b',[]); 
for c=2:12
    combos = nchoosek(1:12,c);
    for t=1:size(combos,1) %number of possible combinations      
        for r=1:size(combos,2) %number of tasks in that combo
            %Calculate and store means of CBS tasks for each group in this combo
            un_mean(t,r)=nanmean(data(un,combos(t,r)));
            im_mean(t,r)=nanmean(data(im,combos(t,r)));
        end
        new_un=0;
        new_bo=0;
        new_im=0;
        %resort ALL DATA ONLY IF ALL TASKS AGREE
        for i=1:size(data,1)
            un_count=0;
            im_count=0;
            for r=1:size(combos,2)
                if data(i,combos(t,r)) >= un_mean(t,r)
                    un_count=un_count+1;
                end
                if data(i,combos(t,r)) <= im_mean(t,r)
                    im_count=im_count+1;
                end
            end  
            %IF THEY ALL AGREE TO MOVE TO UNIMPAIRED
            if un_count==size(combos,2)
                new_un=new_un+1; %unimpaired
            %IF THEY ALL AGREE TO MOVE TO UNIMPAIRED
            elseif im_count==size(combos,2)
                new_im=new_im+1; %impaired
            else
                new_bo=new_bo+1; %borderline
            end
        end
        u=new_un;%(new_un/length(bo)*100);
        i=new_im;%(new_im/length(bo)*100);
        b=new_bo;%(new_bo/length(bo)*100);
        task=combos(t,:);
        results(end+1)=struct('task',{task},'u',u,'i',i,'b',b);
        %sprintf('For task %d: %d people were moved to unimpaired, %d were moved to impaired, %d remained in borderline', task,u,i,b)
    end
end
save('all_participants_resort.mat','results');

tmp=struct2cell(results);
tmp=squeeze(tmp)';
tmp=cell2mat(tmp(:,4));
s=find(tmp==min(tmp));
results(s)