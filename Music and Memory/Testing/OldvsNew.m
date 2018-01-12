%% Old vs New task for Music and Memory study

%% Initialize soundcard and load data
%%%%%%%%%% Setup soundcard for output %%%%%%%%%%
InitializePsychSound;
songhandle = PsychPortAudio('Open', [], [], 0, 44100, 1);

%%%%%%%%% Open serial Port %%%%%%%%%
% define port
sport=serial('/dev/cu.usbserial-A703YW3J','BaudRate',115200);

%%%%%%%%% Load Data %%%%%%%%%%
load('clips.mat'); %take file information from mat file in same folder as this script

%%%%%%%%% Manual Input Variables %%%%%%%%%
commandwindow; 
test=input('Press 1 to open on this screen, Press 2 to open on secondary screen: '); %press 1 for debugging/testing
subID=input('Subject ID: ', 's');
group=input('For group A press 1, for group B press 2: ', 's');
testStart=datestr(now,'yyyymmddTHHMMSSFFF');
%% Setup screen and messages  
%%%%%%%%% Screen Messages %%%%%%%%%
text{1}=['Thank you for your participating in this study. \n\n'...
    'You will hear two short clips of music.\n\n'...
    'Please indicate which short clip is from a song on which you trained\n\n'...
    'Press any key to begin'];
text{2}=['Which clip did you train on and is the most familiar?\n\n' ...
    ' 1        or       2'];
text{3}=['The task is over \n\n'...
    'Thank you for participating'];

black=[0,0,0];
white=[255,255,255];

if test == 1;
    [win, rect] = Screen('Openwindow', 0, black, [0,0,900,600]); % Open win in small box on primary screen.
else
    [win, rect] = Screen('Openwindow', 1, black); % Open win on secondary screen. [Primary screen is "0"]
end

Screen('TextSize', win, 20);

DrawFormattedText(win, text{1}, 'center', 'center', white); Screen('Flip', win);
KbWait([], 2);
%% Task
responses=[];
responses.data=zeros(1,length(clips));
responses.avg=[];
responses.button=[];
rng(sum(100*clock));
responses.AOrder=randperm(23);
responses.BOrder=randperm(23);
for i=1:length(clips)
    A_file=clips(responses.AOrder(i),1); %get A clip
    B_file=clips(responses.BOrder(i),1); %get B clip
    rand=randperm(2);
    if group == '1';
        corr=A_file;
        oth=B_file;
        if rand(1)==1;
            first=corr;
            second=oth;
            responses.first{i}={corr};
            responses.second{i}={oth};
        elseif rand(1)==2;
            first=oth;
            second=corr;
            responses.first{i}={oth};
            responses.second{i}={corr};
        end
    elseif group == '2';
        corr=B_file;
        oth=A_file;
        if rand(1)==1;
            first=corr;
            second=oth;
            responses.first{i}={corr};
            responses.second{i}={oth};
        elseif rand(1)==2;
            first=oth;
            second=corr;
            responses.first{i}={oth};
            responses.second{i}={corr};
        end
    end
    DrawFormattedText(win, '1', 'center', 'center', white); Screen('Flip', win);
    WaitSecs(0.5);
    %play FIRST clip
    %PsychPortAudio('DeleteBuffer',songhandle,1); %clear buffer before clip
    [bufferdata, freq] = audioread(first{1});
    bufferdata=bufferdata';
    PsychPortAudio('FillBuffer', songhandle, bufferdata);
    [~] = PsychPortAudio('Start', songhandle, 1, 0, 1);

    status=PsychPortAudio('GetStatus', songhandle);WaitSecs(0.5);
    while status.Active ==1; % wait until stim is finished playing
        DrawFormattedText(win, '1', 'center', 'center', white); % hold fixation cross while stim is playing
        DrawFormattedText(win, '1', 'center', 'center', white); Screen('Flip', win);
        status=PsychPortAudio('GetStatus', songhandle); 
        WaitSecs(0.5);        
    end
    %PsychPortAudio('DeleteBuffer',songhandle,1); %clear buffer before clip
    %play SECOND clip
    DrawFormattedText(win, '2', 'center', 'center', white); Screen('Flip', win);
    WaitSecs(0.5);
    [bufferdata, freq] = audioread(second{1});
    bufferdata=bufferdata';
    PsychPortAudio('FillBuffer', songhandle, bufferdata);
    [~] = PsychPortAudio('Start', songhandle, 1, 0, 1);

    status=PsychPortAudio('GetStatus', songhandle);WaitSecs(0.5);
    while status.Active ==1; % wait until stim is finished playing
        DrawFormattedText(win, '2', 'center', 'center', white); % hold fixation cross while stim is playing
        DrawFormattedText(win, '2', 'center', 'center', white); Screen('Flip', win);
        status=PsychPortAudio('GetStatus', songhandle); 
        WaitSecs(0.5);        
    end
    DrawFormattedText(win, text{2}, 'center', 'center', white); Screen('Flip', win);
    KbWait([],2);
    [keyIsDown, secs, keyCode, deltaSecs] = KbCheck([]);
    code=KbName(keyCode);
    responses.button{i}={code};
    WaitSecs(0.5);
    
   %% Calculate correct responses
       if strcmp(code,'LeftArrow') == 1 %use this line on a mac
        %if strcmp(code,'left') == 1 %use this line on a PC
            %responses(i)=1;
            if strcmp(first{1},corr{1})==1;
                responses.data(i)=1;
            end
       else
            if strcmp(second{1}, corr{1})==1;
                responses.data(i)=1;
            end
       end
end
responses.avg = (sum(responses.data)/length(clips))*100;
save([subID '_responses_ ' testStart ' .mat'], 'responses');
WaitSecs(0.5);
%% End of task/thank you text
DrawFormattedText(win, text{3}, 'center', 'center', white); Screen('Flip', win);
KbWait([], 2);
sca;