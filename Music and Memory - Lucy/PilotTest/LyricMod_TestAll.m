commandwindow; 
test=input('Press 1 to open on this screen, Press 2 to open on secondary screen: '); %press 1 for debugging/testing
subID=input('Subject ID: ', 's');
%group=input('Group A - press 1, Group B - press 2: ');
testStart=datestr(now,'yyyymmdd');

load('LyricMod_ALL_v2.mat');

black=[0,0,0];
white=[255,255,255];

if test == 1;
    [win, rect] = Screen('Openwindow', 0, black, [0,0,800,500]); % Open win in small box on primary screen.
else
    [win, rect] = Screen('Openwindow', 1, black); % Open win on secondary screen. [Primary screen is "0"]
end

Screen('TextSize', win, 24);
%% Setup screen and messages  
%%%%%%%%% Screen Messages %%%%%%%%%
text{1}=['Thank you for your participating in this study. \n\n\n\n '...
    'In a moment you will be asked to read a series of lyrics from the songs you have been listening to.\n\n '...
    'You will be asked to indicate which lyric is correct. \n\n ' ...
    'Press any key to continue. '];
text{2}=['The task has now ended \n\n' ...
    'Thank you for participating! \n\n' ...
    'Press any key to exit.'];   
%% prep stuff
len=length(lyrics);
responses=[];
responses.data=zeros(1,len);
responses.avg=[];
responses.button=[];
rng(sum(100*clock)); %reset value so randperm is different for each participant.
order=randperm(len); %determine random order of stimuli 
order=order(1:len);
responses.order=order;

%% welcome text
DrawFormattedText(win, text{1}, 'center', 'center', white); Screen('Flip', win);
KbWait([], 2);
%% 
for i=1:len;
    
    j=order(i);
    corr=char(lyrics(j,1));
    oth=char(lyrics(j,2));
        
    rand=randperm(2); %determine which order the lyrics will be presented in
    if rand(1)==1;
        a=corr;
        b=oth;
    elseif rand(1)==2;
        a=oth;
        b=corr;
    end
    responses.a{i}={corr};
    responsse.b{i}={oth};
    
    DrawFormattedText(win,'Which is the correct lyric?', 'center', 300, white); 
    DrawFormattedText(win,['1. ' a ''], 'center', 500, white); 
    DrawFormattedText(win,['2. ' b ''], 'center', 700, white); Screen('Flip', win);
    KbWait([],2);
    [keyIsDown, secs, keyCode, deltaSecs] = KbCheck([]);
    %EEG_data(end+1)=struct('type',{'keystroke'},'timestamp',{KbName(keyCode)}); %save type and name of next keystroke
    code=KbName(keyCode);
    responses.button{i}={code};
    if strcmp(code,'LeftArrow') == 1 %use this line on a mac
    %if strcmp(code,'left') == 1 %use this line on a PC
        %responses(i)=1;
        test=strcmp(lyrics(j,1),a);
        if test==1;
            responses.data(i)=1;
        end
    else
        %responses(i)=2;
         test=strcmp(lyrics(j,1),b);
        if test==1;
            responses.data(i)=1;
        end
    end
end
responses.avg = (sum(responses.data)/len)*100;
save([subID '_responses_ ' testStart ' .mat'], 'responses');
WaitSecs(0.5);

%End of task/thank you text
DrawFormattedText(win, text{2}, 'center', 'center', white); Screen('Flip', win);
KbWait([], 2);

sca;

