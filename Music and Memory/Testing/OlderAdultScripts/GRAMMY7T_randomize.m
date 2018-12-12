% function trialorder = GRAMMY7T_randomize(nmbs)
nmbs = 20;

rng('shuffle')
stim_types = {'MS1' 'MS2' 'MC' 'NM' 'SCR'};
stim_nums  = 1:5;
tempo      = [130, 150];
call_type  = {'reg' 'scr'};

types_code = 1:length(unique(stim_types));
tempo_code = 1:length(unique(tempo));
call_code  = 1:length(unique(call_type));

stim_rep   = length(stim_nums)*length(tempo_code)*length(call_code);
num_rep    = length(tempo_code)*length(call_code);
tempo_rep  = length(call_code);

STIMS     = [];
types_vec = [];
nums_vec  = [];
tempo_vec = [];
call_vec  = [];
for ii = 1:length(types_code)
    types_vec = [types_vec; repmat(types_code(ii),stim_rep,1)];
    for jj = 1:length(stim_nums)
        nums_vec = [nums_vec; repmat(stim_nums(jj),num_rep,1)];
        for kk = 1:length(tempo_code)
            tempo_vec = [tempo_vec; repmat(tempo_code(kk),tempo_rep,1)];
            for ll = 1:length(call_code)
                call_vec = [call_vec; call_code(ll)];
            end
        end
    end
end
STIMS  = [types_vec nums_vec tempo_vec call_vec];

[~,IX] = sort(rand(length(STIMS),1));
SHUF   = STIMS(IX,:);

% mm = 0;
% while ~(mm == nmbs && (abs(sum(MB(:,3)==1) - sum(MB(:,3)==2)) > 2) || (abs(sum(MB(:,4)==1) - sum(MB(:,4)==2)) > 2))
trialorder = [];
for mm = 1:nmbs
    mm
    [~,tix]    = sort(rand(length(types_code),1));
    types_rand = types_code(tix);
    
    % get all the right things in the block (unique rhythm tokens, not too
    % many of one tempo or call type), get rid of used items
    MB         = ones(length(types_code),size(SHUF,2));
    start = clock;
    while (length(unique(MB(:,2))) < length(stim_nums)) || (abs(sum(MB(:,3)==1) - sum(MB(:,3)==2)) > 2) || (abs(sum(MB(:,4)==1) - sum(MB(:,4)==2)) > 2)
        idx = [];
        for nn = 1:length(types_rand)
            opt  = find(SHUF(:,1) == types_rand(nn));
            idx(nn) = opt(randi(length(opt)));
            info = SHUF(idx(nn),:);
            MB(nn,:) = info;
        end
        if (etime(clock,start) > 3)
            disp('timeout!')
            break
        end
    end
    tmp = [];
    for oo = 1:length(SHUF)
        if ~ismember(idx,oo)
            tmp = [tmp; SHUF(oo,:)];
        end
    end
    SHUF = tmp;
    
    
    %     % no need to enter this loop if the shit is impossible
    %     if mm == nmbs && (abs(sum(MB(:,3)==1) - sum(MB(:,3)==2)) > 2) || (abs(sum(MB(:,4)==1) - sum(MB(:,4)==2)) > 2)
    %         break
    %     else
    
    % make sure not too many tempo or call types happen sequentially
    start = clock;
    numreps = 2; % max reps allowed in a single mini-block
    repcnt = [0 0];
    for h = 1:size(MB,1)
        if h > 1
            if MB(h,3) == MB(h-1,3)
                repcnt(1) = repcnt(1) + 1;
            end
            if MB(h,4) == MB(h-1,4)
                repcnt(2) = repcnt(2) + 1;
            end
            
            while repcnt(1) >= numreps || repcnt(2) >= numreps
                [~,mbrix] = sort(rand(size(MB,1),1));
                MB = MB(mbrix,:);
                
                if MB(h,3) == MB(h-1,3)
                    repcnt(1) = repcnt(1) + 1;
                else
                    repcnt(1) = 0;
                end
                if MB(h,4) == MB(h-1,4)
                    repcnt(2) = repcnt(2) + 1;
                else
                    repcnt(2) = 0;
                end
                if (etime(clock,start) > 3)
                    disp('timeout!')
                    break
                end
            end
        end
        
    end
    trialorder = [trialorder; MB];
end

% end
% end







