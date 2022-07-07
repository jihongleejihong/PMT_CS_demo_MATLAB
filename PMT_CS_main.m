clear;

%% Exp preparation

% add paths
addpath('lib', 'local', genpath('data'));

% load apparatus file (need to change)
ap = vcc_apparatus.Jeonil;

% random seed
if exist('rng', 'file') == 2
    randinfo = rng('shuffle');
    randseed = randinfo.Seed;
else
    rand('seed', GetSecs); %#ok<RAND>
    randseed = rand('seed');
end

% get experimental info.

if ~exist('SID', 'var') || isempty(SID)
    prompt = {'Enter subject''s name: '};
    dlg_title = 'Exp information';
    num_lines = 1;
    defaultans = {''};
    options.Resize = 'on';
    answer = inputdlg(prompt,dlg_title,num_lines,defaultans,options);
    SID = answer{1};
end

% data save path
matfile = fullfile('data', 'Exp', strcat(SID, '_', datestr(now (), 'yyyy-mm-dd.HH_MM_SS'), '.mat'));

ApplyGammaTable(TargetLum_sRGB);

%% OPEN EXP window
try
    % initialize psychtoolbox screen
    ListenChar(2);
    
    [wptr, rect] = Screen('OpenWindow', 0, [127 127 127], [0 0 ap.ScreenWidth ap.ScreenHeight]); % initial background color
    Screen('BlendFunction', wptr, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
    Screen('HideCursorHelper', wptr);
    Screen('TextFont', wptr, 'Trebuchet MS');
    Screen('TextSize', wptr, 24);
    
    % load workspace file (/local)
    ws = PMT_CS_Workspace(wptr, rect, ap);
    
    % DEBUG
    ws.AutoPilot = false;
    ws.DebugStim = false; %% if true, stimuli are held until the spacebar is pressed.
    
    % make Exp conditions (correlation, task, test)
    
    ws.corr_cond = [1 0]';
%     ws.test_feat = [1, 2]'; % 1 = size, 2 = color
    ws.test_feat = [1]'; % 1 = size, 2 = color
    ws.test_level = [-3:3]'; %
    ws.stim_order = [1, 2]'; % 1 = test set in first interval, 2 = test probe in second interval
    
    ws.feedback = audioplayer(sind((1:600) / 8000 * 360 * 800), 8000);
    
    % PMT
    PMT_Mat = expmat( ...
        ws.corr_cond, ws.test_feat, ws.mean(1), ws.mean(2), ws.sigma(1), ws.sigma(2) ...
        );
    
    [PMT_seq, PMT_Mat, PMT_n] = expseq(PMT_Mat, 5); % make practice sequence (reps = 1)
    
    SimpleTextScreen('Press SPACE to Start PMT Practice', ws);
    
    for PMT_t = 1:PMT_n
        %         trial
        PMTcond = PMT_Mat(PMT_seq(PMT_t), 1:7);
        
        [resp, test_level, target_level, rt] = PMT_CS_Trial(PMTcond, ws, ap);
        %         record data
        PMT_Mat(PMT_seq(PMT_t), 8) = resp;
        PMT_Mat(PMT_seq(PMT_t), 9) = test_level;
        PMT_Mat(PMT_seq(PMT_t), 10) = target_level;
        PMT_Mat(PMT_seq(PMT_t), 11) = rt;
        
        if PMT_t >= 5
            if corr2(PMT_Mat(1:PMT_t, [9, 10]), PMT_Mat(1:PMT_t, [9, 8])) > 0.9
                PMT_t = PMT_n;
            end
        end
    end

    
    save(matfile);
    SimpleTextScreen('Thanks for Your Participation', ws);
    
    % wrap up psychtoolbox screen
    ResetGammaTable;
    Screen('CloseAll');
    ListenChar(1);
    
catch e
    % clear psychtoolbox screen & rethrow exception
    ResetGammaTable;
    Screen('CloseAll');
    ListenChar(1);
    rethrow(e);
end