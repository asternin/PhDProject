%navigate to folder
files=dir('*.xlsx');
results=cell(length(files),18);
for i=1:length(files);
    [~,~,raw]=xlsread(files(i).name);
    results(i,1)={files(i).name};
    raw(1,:)=[]; %remove header row
    for j=1:size(raw,1);
        if cell2mat(raw(j,2)) == 1 && strcmp(raw(j,7),'ON')==1
            results(i,j+1)={1}; %CORRECT identification of SAME
        elseif cell2mat(raw(j,2)) == 0 && strcmp(raw(j,7),'OFF')==1
            results(i,j+1)={1}; %CORRECT identification of DIFFERENT
        else 
            results(i,j+1)={0}; %INCORRECT identification
        end
    end
end
save('BeatPerceptionResults.mat','results')