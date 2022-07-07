function PMT_DrawRefresh(x, y, btns, ws, ap, test_feat, set_stimMat, c_sigma, s_sigma, test_color, test_size) %#ok<INUSL>

coord_range = linspace(ws.bar_rect(1), ws.bar_rect(3), 100);

[x_dist, closestIndex] = min(abs(coord_range - x));

y_dist = abs((ws.bar_rect(4) + ws.bar_rect(2)) ./2 - y);

% if x_dist <= 0.7 * ap.pxpd 
if x_dist <= 0.7 * ap.pxpd && y_dist <= 0.7 * ap.pxpd 
    
    switch test_feat
    case 1 % color -> size
        
        s_bar_range = linspace(min(set_stimMat(:, 2)) - s_sigma./2, max(set_stimMat(:, 2)) + s_sigma./2, 100);
        s_bar_mat = zeros(1, 100, 3);
        s_bar_txt = Screen('MakeTexture', ws.wptr, uint8(imresize(s_bar_mat, ws.bar_size, 'nearest')));
        
        Screen('DrawTexture', ws.wptr, s_bar_txt, [], ws.bar_rect); % size_bar      
        Screen('FillOval', ws.wptr, uint8(test_color), pairs2rects(ws.test_coord', cvt_psy2phy_area(s_bar_range(closestIndex)) .*ap.pxpd)); % changed test probe % test probe
        
        case 2 % size -> color
        
        
        c_bar_range = linspace(min(set_stimMat(:, 1)) - c_sigma./2, max(set_stimMat(:, 1)) + c_sigma./2, 100);
        c_bar_mat = Lab_ColorWheel(c_bar_range, ws.lab, ws.lab_rad) .* 255;
        closestColor = [c_bar_mat(:, closestIndex, 1), c_bar_mat(:, closestIndex, 2), c_bar_mat(:, closestIndex, 3)]';
        
        c_bar_txt = Screen('MakeTexture', ws.wptr, uint8(imresize(c_bar_mat, ws.bar_size, 'nearest')));
        
        
        Screen('DrawTexture', ws.wptr, c_bar_txt, [], ws.bar_rect); % color_bar
        Screen('FillOval', ws.wptr, closestColor, pairs2rects(ws.test_coord', test_size)); % test probe
           
        
        
    end
       
else
    
switch test_feat
    case 1 % color -> size
        
        s_bar_range = linspace(min(set_stimMat(:, 2)) - s_sigma./2, max(set_stimMat(:, 2)) + s_sigma./2, 100);
        s_bar_mat = zeros(1, 100, 3);
        s_bar_txt = Screen('MakeTexture', ws.wptr, uint8(imresize(s_bar_mat, ws.bar_size, 'nearest')));
        
        
        Screen('DrawTexture', ws.wptr, s_bar_txt, [], ws.bar_rect); % size_bar
        Screen('FillRect', ws.wptr, test_color, pairs2rects(ws.test_coord', 5 .*ap.pxpd));  % test probe
             
        
        
        case 2 % size -> color

        c_bar_range = linspace(min(set_stimMat(:, 1)) - c_sigma./2, max(set_stimMat(:, 1)) + c_sigma./2, 100);
        c_bar_mat = Lab_ColorWheel(c_bar_range, ws.lab, ws.lab_rad) .* 255;
%         c_bar_mat = Lab_ColorWheel(c_bar_range, ws.lab, ws.lab_rad) .* 255;
        
        c_bar_txt = Screen('MakeTexture', ws.wptr, uint8(imresize(c_bar_mat, ws.bar_size, 'nearest')));
%         c_bar_txt = Screen('MakeTexture', ws.wptr, c_bar_mat);
        
        
        Screen('DrawTexture', ws.wptr, c_bar_txt, [], ws.bar_rect); % color_bar
%         Screen('DrawTextures', ws.wptr, c_bar_txt, []); % color_bar

        Screen('FillOval', ws.wptr, [0, 0, 0], pairs2rects(ws.test_coord', test_size)); % test probe
        
        
end






        if ~isfield(ws, 'AutoPilot') || ~ws.AutoPilot
        else
            WaitSecs(0.5)           
        end    

end
    Screen('DrawDots', ws.wptr, [x y], 10, 255, [], 2);
    Screen('Flip', ws.wptr);
end