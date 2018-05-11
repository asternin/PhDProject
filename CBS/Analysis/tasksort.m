%read in data
%6=DT, 7=OOO, 8=SP
%9=GR,10=DS, 11=TS
%12=PA, 13=SS, 14=FM
%15=R, 16=P, 17=ML
tasks={'DT','OOO','SP','GR','DS','TS','PA','SS','FM','R','P','ML'};
data=xlsread('DataforR.xlsx');
%create categories based on MoCA scores
c=size(data,2);
for i=1:size(data,1);
    if data(i,4) >= 27;
        data(i,c+1)=3; %unimpaired
    elseif data(i,4)<27 && data(i,4)>22;
        data(i,c+1)=2; %borderline
    elseif data(i,4)<= 22;
        data(i,c+1)=1; %impaired
    end
end
%get indices for three groups
un=find(data(:,c+1)==3);
bo=find(data(:,c+1)==2);
im=find(data(:,c+1)==1);
%delete everything except task scores
data=data(:,[6:17]);
% %%
% sprintf('CATEGORIZING JUST BORDERLINE PARTICIPANTS')
% for t=1:12;
%     %Calculate means of CBS tasks for group 1 and group 3
%     un_mean=nanmean(data(un,t));
%     im_mean=nanmean(data(im,t));
%     new_un=0;
%     new_bo=0;
%     new_im=0;
%     %resort borderline
%     for i=1:size(bo,1);
%         if data(bo(i),t) >= un_mean;
%             new_un=new_un+1; %unimpaired
%         elseif data(bo(i),t) < un_mean && data(bo(i),t) > im_mean;
%             new_bo=new_bo+1; %borderline
%         elseif data(bo(i),t)<= im_mean;
%             new_im=new_im+1; %impaired
%         end
%     end
%     u=(new_un/length(bo)*100);
%     i=(new_im/length(bo)*100);
%     b=(new_bo/length(bo)*100);
%     task=tasks{t};
%     sprintf('For task %s: %.1f%% of people were moved to unimpaired, %.1f%% were moved to impaired, %.1f%% remained in borderline',...
%         task,u,i,b)
% end
% %%
% sprintf('CATEGORIZING ALL PARTICIPANTS')
% for t=1:12;
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
%Calculate means of CBS tasks for group 1 and group 3 - resort ALL
%%
sprintf('all combos')
un_mean=[];
im_mean=[];
results=[];
for c=2:3
    combos = combntns(1:12,c);
    for t=1:size(combos,1); %number of possible combinations      
        for r=1:size(combos,2); %number of tasks in that combo
            %Calculate and store means of CBS tasks for each group in this combo
            un_mean(t,r)=nanmean(data(un,combos(t,r)));
            im_mean(t,r)=nanmean(data(im,combos(t,r)));
        end
        new_un=0;
        new_bo=0;
        new_im=0;
        %resort borderline only if all tasks agree
        for i=1:size(bo,1); 
            un_count=0;
            im_count=0;
            for r=1:size(combos,2);
                if data(bo(i),combos(t,r)) >= un_mean(t,r);
                    un_count=un_count+1;
                end
                if data(bo(i),combos(t,r)) <= im_mean(t,r);
                    im_count=im_count+1;
                end
            end  
            %IF THEY ALL AGREE TO MOVE TO UNIMPAIRED
            if un_count==size(combos,2);
                new_un=new_un+1; %unimpaired
            %IF THEY ALL AGREE TO MOVE TO UNIMPAIRED
            elseif im_count==size(combos,2);
                new_im=new_im+1; %impaired
            else
                new_bo=new_bo+1; %borderline
            end
        end
        u=(new_un/length(bo)*100);
        i=(new_im/length(bo)*100);
        b=(new_bo/length(bo)*100);
        task=combos(t,:);
        results{c,t}={task,u,i,b};
        %sprintf('For task %s: %.1f%% of people were moved to unimpaired, %.1f%% were moved to impaired, %.1f%% remained in borderline',...
        %    task,u,i,b)
    end
end
save('results.mat','results');