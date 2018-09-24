cd('Z:\Avital\PhD-MusicFamiliarity\LabSessionTests\LyricModResults')
%load('101_responses_ 20170622 .mat')
%load('LyricMod_FinalGroupA.mat');
acc=[];
TotalAcc=[];

files=dir('1*');
for f=1:length(files);
     load(files(f).name);
     
     if length(responses.data)==12;
         den=10;
     else
         den=length(responses.data);
     end
     acc=(sum(responses.data)/den)*100;
     TotalAcc(f,1)=acc;
end

