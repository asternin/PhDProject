% function data = GRAMMY7T_experiment(subj,session,human_or_monkey,basedir)

% EXPERIMENT STUFF:
expdir  = strcat(basedir,'experiment\');
datadir = strcat(basedir,'data\');
stimdir = strcat(basedir,'stimuli\');  
nBlocks = 10;
keysOfInterest = zeros(1,256);
keysOfInterest(KbName({'5%','t'})) = 1;
trigs   = find(keysOfInterest);
exitKey = zeros(1,256);
exitKey(KbName({'tab'})) = 1;
KbQueueCreate(); % make queue for abort key condition

rtype   = {'MS1' 'MS2' 'MC' 'NM' 'SCR'};

% GET RANDOMIZATION:
if human_or_monkey == 1
    load(strcat(expdir,'lists\trialorder',num2str(subj),'.mat'))
elseif human_or_monkey == 2
    cnt = 0;
    for a = 1:subj
        for b = 1:session
            cnt = cnt + 1;
        end
    end
    load(strcat(expdir,'lists\trialorder',num2str(cnt),'.mat'))
end

% GET ITIs:
itis    = [2 6 11 15];
weights = [4 2 2 1];
block_ITIs = [];
for c = 1:length(itis)
    block_ITIs = [block_ITIs; repmat(itis(c),weights(c),1)];
end

% INITIAL PARAMS:
InitializePsychSound;
pahandle = PsychPortAudio('Open',[],[],0,44100,1);

% VISUAL STUFF:
try
    sca;                                             % close all screens
    screens      = Screen('Screens');                % get all screens available
    screenNumber = max(screens);                     % present stuff on the last screen
    Screen('Preference', 'SkipSyncTests', 1);
    white   = WhiteIndex(screenNumber);              % get white given the screen used
    
    bgcolor = 0;                                     % background color 0-255
    txtcolor = round(white*0.8);                     % text color 0-255
    [shandle, wRect] = PsychImaging('OpenWindow', screenNumber, bgcolor); % open window
    
    % Select specific text font, style and size:
    Screen('TextFont', shandle, 'courier new');
    Screen('TextSize', shandle, 35);
    Screen('TextStyle', shandle, 1);
    HideCursor;
    
    % FIXATION:
    dotSize = 15;
    fixationDot = [-dotSize/2 -dotSize/2 dotSize dotSize];
    fixationDot = CenterRect(fixationDot,wRect);
    
    
    % START THE EXPERIMENT:
    onsets = [];
    tcnt   =  1;
    for b = 1:nBlocks
        
    DrawFormattedText(shandle, ' ', 'center', 'center', txtcolor);
    Screen('Flip', shandle);
    
        % RANDOMIZE ITIS:
        [~, ri] = sort(rand(size(block_ITIs)));
        BI      = block_ITIs(ri);
        
        % 3 DUMMIES:
        triggers = 0;
        while triggers < 4
            [choiceTime, keyCode] = KbWait([],2);
            [val, choiceKeyCode] = max(keyCode);
            if sum(ismember(trigs,choiceKeyCode)) > 0                
                timestamp = GetSecs;
                triggers = triggers + 1;
            end            
        end
        
        % START:
        ntrials = length(trialorder)/nBlocks;
        for t = 1:ntrials
                
                % FIXATION DOT:
                Screen('FillOval',shandle,txtcolor,fixationDot);
                Screen('Flip',shandle);
                WaitSecs(0.5)
                
                % AUDIO STUFF:
                if trialorder(tcnt,1) == 1 || trialorder(tcnt,1) == 2
                    foldername = 'MS';
                else
                    foldername = rtype{trialorder(tcnt,1)};
                end
                if trialorder(tcnt,3) == 1
                    tempo = '130';
                elseif trialorder(tcnt,3) == 2
                    tempo = '150';  
                end
                if trialorder(tcnt,4) == 1
                    call = 'reg';
                elseif trialorder(tcnt,4) == 2
                    call = 'scr';
                end
                soundfile = strcat(rtype{trialorder(tcnt,1)},'_',num2str(trialorder(tcnt,2)),'_',call,'_',tempo,'.wav');
                [tone, sf] = audioread(strcat(stimdir,foldername,filesep,soundfile));
                dur = length(tone)/sf;
                                      
                PsychPortAudio('FillBuffer',pahandle,tone');
                tim = PsychPortAudio('Start',pahandle,1,0,1);     
                stim_onset = GetSecs - timestamp;
                WaitSecs(dur)
                
                % ITI:
                DrawFormattedText(shandle, '', 'center', 'center', txtcolor);
                Screen('Flip', shandle);
                KbQueueStart();
                if t < ntrials
                    WaitSecs(BI(t))
                end
                
                    % Check for abort signal:
                    KbQueueStop();
                    [pressed, firstPress, ~, ~, ~]= KbQueueCheck();
                    if pressed == 1
                        keysPressed = find(firstPress ~= 0);
                        if keysPressed(1) == find(exitKey)
                            error('Experiment terminated by user.')
                        end
                    end
                    
                    % KEEP EVERYTHING:
                    onsets = [onsets; tcnt b trialorder(tcnt,:) stim_onset dur];
                    
                    % COUNTER:
                    tcnt = tcnt + 1;            
                    
                    
        end
        
        % BREAK:
        if b < nBlocks
            DrawFormattedText(shandle, 'Take a short break.', 'center', 'center', txtcolor);
            Screen('Flip', shandle);
            [keyIsDown, endtime, keyCode] = KbCheck;
            while ~keyIsDown,
                [keyIsDown, endtime, keyCode] = KbCheck;
            end
        elseif b == nBlocks
            DrawFormattedText(shandle, 'Done.', 'center', 'center', txtcolor);
            Screen('Flip', shandle);
            [keyIsDown, endtime, keyCode] = KbCheck;
            while ~keyIsDown,
                [keyIsDown, endtime, keyCode] = KbCheck;
            end
        end
    end
    
    
    sca;
catch
    sca;
    rethrow(lasterror);
end

% SAVE DATA:
if human_or_monkey == 1
    species = 'human';
elseif human_or_monkey == 2
    species = 'monkey';
end
save(strcat(datadir,'onsets_',species,'_subj',num2str(subj),'_sess',num2str(session),'txt'),'onsets')
