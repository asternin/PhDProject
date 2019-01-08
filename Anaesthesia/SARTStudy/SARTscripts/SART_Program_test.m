clear all
%Screen('Preference', 'SkipSyncTests', 1);
%% Initialize soundcard and load data
%%%%%%%%%% Setup soundcard for output %%%%%%%%%%
% InitializePsychSound;
% songhandle = PsychPortAudio('Open', [], [], 0, 44100, 1);
% 
% %%%%%%%%% Open serial Port %%%%%%%%%
% % define port
% sport=serial('/dev/cu.usbserial-A703YW3J','BaudRate',115200);

%%%%%%%%% Manual Input Variables %%%%%%%%%
commandwindow; 
test=input('Press 1 to open on this screen, Press 2 to open on secondary screen: '); %press 1 for debugging/testing
subject=input('Subject ID: ', 's');

black=[0,0,0];
white=[255,255,255];

if test == 1;
    [win, rect] = Screen('Openwindow', 0, black, [0,0,900,600]); % Open win in small box on primary screen.
else
    [win, rect] = Screen('Openwindow', 1, black); % Open win on secondary screen. [Primary screen is "0"]
end

%%%%%%%%% Fixation Cross Initialization %%%%%%%%%
[X,Y] = RectCenter(rect);
Y=Y+5;
FixCross = [X-1,Y-20,X+1,Y+20;X-20,Y-1,X+20,Y+1];

Screen('TextSize', win, 40);

KbQueueCreate;
KbQueueFlush;
%% START PROGRAM
time_start=GetSecs;
%Reseed the random-number generator
rand('state',sum(100*clock));

fclose('all');

try %embedded in try-catch in case something goes wrong
    
    info = 'The experiment is going to start. \n\nPress any key to begin';
    DrawFormattedText(win, info, 'center', 'center', white); Screen('Flip', win);
    KbWait([], 2);
    
    experiment_info=['You will see a series of digits on the screen\n\n' ...
                'You need to IGNORE the number 3'];
    DrawFormattedText(win, experiment_info, 'center', 'center', white); Screen('Flip',win);
    KbWait([], 2);
    
    experiment_info2=['Please push the button to EVERY digit\n\nEXCEPT the number 3\n\n' ...
                'As quickly and as accurately as posssible'];
    DrawFormattedText(win, experiment_info2, 'center', 'center', white); Screen('Flip',win);
    KbWait([], 2);
    
    experiment_info3=['This is a practice run\n\n' ...
                'In the experiment, you will hear a story while doing this task'];
    DrawFormattedText(win, experiment_info3, 'center', 'center', white); Screen('Flip',win);
    KbWait([], 2);
    
    experiment_info4=['Ask the experimenter any questions\n\n' ...
                'When you are ready, push any key to start'];
    DrawFormattedText(win, experiment_info4, 'center', 'center', white); Screen('Flip',win);
    KbWait([], 2);
    
    DrawFormattedText(win, [], 'center', 'center', white); Screen('Flip',win);
    WaitSecs(3);


    CurrTime=GetSecs;

    while GetSecs-CurrTime < 30
        KbQueueStart;
        numbers=randperm(9);
        for n=1:length(numbers);
            DrawFormattedText(win, num2str(numbers(n)), 'center', 'center', white); 
            [VBLTimestamp,StimulusOnsetTime, FlipTimestamp, Missed, Beampos]=Screen('Flip',win);
            WaitSecs(0.25);
            [pressed, firstPress, firstRelease, lastPress, lastRelease] = KbQueueCheck;
            Screen('FillRect',win,white,FixCross'); Screen('Flip',win);
            WaitSecs(0.9);
        end   
    end
    KbQueueStop;
    KbQueueFlush;
 
final = 'This practice has finished. \n\nPress any key to end';
DrawFormattedText(win, final, 'center', 'center', white); Screen('Flip', win);
KbWait([], 2);
sca;

catch
    % close all windows and return
    sca;
    rethrow(lasterror)
    return;
end;