function ws = PMT_CS_Workspace(wptr, rect, ap)
ws = base_workspace(wptr, rect); 

%% Exp config

ws.reps = 3; % repetition per each condition / considering to-be-aggreated conditions (corr (2) / order(2): reps 4 -->  16 per condition
ws.preps = 1;

%% number of stimuli
ws.setSize = 16;
ws.grid_interval = 2.3 .* ap.pxpd;

%% statistical properties of set
ws.mean = [90, 1.2];
ws.sigma = [30, 0.35]; % sd of [color, size]
ws.test_step_size = [16, 0.185]; % of [color, size]

%% feature config
ws.lab = [70, 20, 38];
ws.lab_rad = 60;

%% display config
% stim duration
% ws.stim_duration = 0.49;
ws.stim_duration = 0.49;
ws.ISI = 0.49;




%% response
ws.test_coord = [ws.cx, ws.cy- 3 .* ap.pxpd];
ws.bar_size = [round(1 .* ap.pxpd), (20 .* ap.pxpd)];
ws.bar_rect = pairs2rects([ws.cx, ws.cy + 3 .*ap.pxpd]', ws.bar_size(2), ws.bar_size(1));



%% etc.

% text parameter
ws.SimpleText_Color = 0;

% fixation parameters

% ws.crosshair = { round(9 * ap.pxpd) + 12, round(9 * ap.pxpd), 0}; % black
ws.cross_prep    = struct('cr', 8, 'cc', [0, 0, 0]); % center cross
ws.cross_start    = struct('lr', 6, 'lc', [0 0 0]); % center cross
ws.cross_resp    = struct('lr', 6, 'lc', [255 0 0]); % center cross
% ws.crosshair_resp = { round(9 * ap.pxpd) + 12 , round(9 * ap.pxpd), 255}; % white

end