function [resp, test_level, target_level, rt] = PMT_CS_Trial(tcond, ws, ap)

[~, corrCond, test_feat, c_mu, s_mu, c_sigma, s_sigma] = feval(@(x) x{:}, num2cell(tcond));

% while generating stimuli
SimpleFixation(ws.wptr, ws.cross_prep);
Screen('Flip', ws.wptr);


tic

[set_stimMat, ~] = mk_corr_vectors(ws.setSize, [c_mu, s_mu], [c_sigma, s_sigma], corrCond);

test_pair = set_stimMat(randsample(1:ws.setSize, 1), :);

set_coords = mk_grid_coord(ws.setSize, ws.grid_interval, ws.grid_interval ./ 10);

t_size_rects = pairs2rects(set_coords', cvt_psy2phy_area(set_stimMat(:, 2))' .* ap.pxpd);


set_color = mk_color_mat(set_stimMat(:, 1), ws.lab, ws.lab_rad);
test_color = mk_color_mat(test_pair(1), ws.lab, ws.lab_rad);

test_size = cvt_psy2phy_area(test_pair(2)).* ap.pxpd;

%% duration info.
display_onset_delay = 0.6 + 0.4 * rand;


%% trial start

SimpleFixation(ws.wptr, ws.cross_start);
Screen('Flip', ws.wptr);
if ~isfield(ws, 'AutoPilot') || ~ws.AutoPilot
    expkey(KbName('space'));
end

trial_onset = Screen('Flip', ws.wptr);


% Draw Display set

Screen('FillOval', ws.wptr, set_color, OffsetRect(t_size_rects, ws.cx, ws.cy))

disp_onset = Screen('Flip', ws.wptr, trial_onset + display_onset_delay);

% DEBUG: hold stim. display
if isfield(ws, 'DebugStim') && ws.DebugStim
    expkey(KbName('space'));
end

disp_offset = Screen('Flip', ws.wptr, disp_onset + ws.stim_duration);


% test screen
switch test_feat
    case 1 % color -> size
        
        s_bar_range = linspace(min(set_stimMat(:, 2)) - s_sigma./2, max(set_stimMat(:, 2)) + s_sigma./2180, 100);
        s_bar_mat = zeros(1, 100, 3);
        s_bar_txt = Screen('MakeTexture', ws.wptr, uint8(imresize(s_bar_mat, ws.bar_size, 'nearest')));
        
        Screen('DrawTexture', ws.wptr, s_bar_txt, [], ws.bar_rect); % size_bar
        Screen('FillRect', ws.wptr, test_color, pairs2rects(ws.test_coord', 5 .*ap.pxpd));  % test probe
        
        
    case 2 % size -> color
        
        c_bar_range = linspace(min(set_stimMat(:, 1)) - c_sigma./2, max(set_stimMat(:, 1)) + c_sigma./2, 100);
        c_bar_mat = Lab_ColorWheel(c_bar_range, ws.lab, ws.lab_rad) .* 255;
        
        c_bar_txt = Screen('MakeTexture', ws.wptr, uint8(imresize(c_bar_mat, ws.bar_size, 'nearest')));
        
        
        Screen('DrawTexture', ws.wptr, c_bar_txt, [], ws.bar_rect); % color_bar
        
        Screen('FillOval', ws.wptr, test_color, pairs2rects(ws.test_coord', test_size)); % test probe
        
end

test_onset = Screen('Flip', ws.wptr, disp_offset +  ws.ISI);


% DEBUG: hold stim. display
if isfield(ws, 'DebugStim') && ws.DebugStim
    expkey(KbName('space'));
end


% response display

SimpleFixation(ws.wptr, ws.cross_resp);



% DEBUG: hold stim. display
if isfield(ws, 'DebugStim') && ws.DebugStim
    expkey(KbName('space'));
end


SetMouse(ws.cx, ws.cy, ...
    ws.wptr);

[closestIndex, rt] = PMT_mouse(ws, ...
    @(x, y, btns) PMT_BtnDown(x, y, btns, ap, ws), ...
    @(x, y, btns) PMT_DrawRefresh(x, y, btns, ws, ap, test_feat, set_stimMat, c_sigma, s_sigma, test_color, test_size), [], test_onset ...
    ); %#ok<NOPRT,NASGU,ASGLU>

% HideCursor;
switch test_feat
    case 1 % color -> size
        
        resp = s_bar_range(closestIndex);
        test_level = test_pair(1);
        target_level = test_pair(2);
    case 2 % size -> color
        resp = c_bar_range(closestIndex);
        test_level = test_pair(2);
        target_level = test_pair(1);
end



disp_duration = disp_offset - disp_onset;






end