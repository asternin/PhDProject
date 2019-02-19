function ISS3(id,subj)

% EXPERIMENT STUFF:
%expdir  = strcat(basedir,'experiment\');
datadir = 'data\';
stimdir = 'VolumeNormalized\';

keysOfInterest = zeros(1,256);
keysOfInterest(KbName({'5%','t'})) = 1;
trigs   = find(keysOfInterest);
exitKey = zeros(1,256);
exitKey(KbName({'tab'})) = 1;
KbQueueCreate(); % make queue for abort key condition

%rtype   = {'MS1' 'MS2' 'MC' 'NM' 'SCR'};


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
    %HideCursor;
    
%     % FIXATION:
%     dotSize = 15;
%     fixationDot = [-dotSize/2 -dotSize/2 dotSize dotSize];
%     fixationDot = CenterRect(fixationDot,wRect);
    
    
    % START THE EXPERIMENT:
    onsets = [];
    tcnt   =  1;
        
    DrawFormattedText(shandle, ' Wait for triggers ', 'center', 'center', txtcolor); Screen('Flip', shandle);
    
%         % RANDOMIZE ITIS:
%         [~, ri] = sort(rand(size(block_ITIs)));
%         BI      = block_ITIs(ri);
        
        % 3 DUMMIES:
        triggers = 0;
        while triggers < 4
            [choiceTime, keyCode] = KbWait([],2);
            [val, choiceKeyCode] = max(keyCode);
            if sum(ismember(trigs,choiceKeyCode)) > 0                
                timestamp = GetSecs;
                triggers = triggers + 1;
            end
             DrawFormattedText(shandle, sprintf('%d',triggers), 'center', 'center', txtcolor); Screen('Flip', shandle);
        end
        
        % START:
                
                % FIXATION DOT:
                %Screen('FillOval',shandle,txtcolor,fixationDot);
                DrawFormattedText(shandle, 'Stimulus is playing.', 'center', 'center', txtcolor); Screen('Flip',shandle);
                %WaitSecs(0.5)
                
                % AUDIO STUFF:
                
                soundfile = [stimdir 'ISS_Speech_ThinkingAboutYou_Spoken.mp3'];
                [stim, sf] = audioread(soundfile);
                %[stim, sf] = audioread(strcat(stimdir,foldername,filesep,soundfile));
                dur = length(stim)/sf;
                                      
                PsychPortAudio('FillBuffer',pahandle,stim(:,1)');
                tim = PsychPortAudio('Start',pahandle,1,0,1);     
                stim_onset = GetSecs - timestamp;
                WaitSecs(dur)
                
%                 % ITI:
%                 DrawFormattedText(shandle, '', 'center', 'center', txtcolor);
%                 Screen('Flip', shandle);
%                 KbQueueStart();
%                 if t < ntrials
%                     WaitSecs(BI(t))
%                 end
                
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
                    onsets = [onsets; tcnt stim_onset dur];
                    
                    % COUNTER:
                    tcnt = tcnt + 1;            
                    
        
        % END:
            DrawFormattedText(shandle, 'Done.', 'center', 'center', txtcolor);
            Screen('Flip', shandle);
            [keyIsDown, endtime, keyCode] = KbCheck;
            while ~keyIsDown
                [keyIsDown, endtime, keyCode] = KbCheck;
            end   
    sca;
catch
    sca;
    rethrow(lasterror);
end

% SAVE DATA:
save(strcat(datadir,'onsets_subj_',id),'onsets')
%need to save names=[], onsets=[],  durations=[]; for short clips only