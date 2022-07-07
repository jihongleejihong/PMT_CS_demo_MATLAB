function ScheduledBreak(wptr, rect, secs, text, color, offset, size)
	if exist('text', 'var') == 0 
		text = 'Time left >> % 2d:%02d';
	end
	if ~exist('color', 'var')  || isempty(color)  color = [0 0 0]; end %#ok<SEPEX>
	if ~exist('offset', 'var') || isempty(offset) offset = [0 0];  end %#ok<SEPEX>
	if ~exist('size', 'var')   || isempty(size)   size = Screen('TextSize', wptr);  end %#ok<SEPEX>

	info = Screen('GetWindowInfo', wptr);
	stereo = (info.StereoMode > 0);

	timeout = GetSecs + secs;
	while GetSecs < timeout
		secs_left = timeout - GetSecs;
		min = floor(secs_left / 60);
		sec = floor(secs_left - min * 60);
		secs_text = sprintf(text, min, sec);

		[~, ~, keycode] = KbCheck;
		if keycode(27) == 1
			break;
        end
       
		if stereo
			Screen('SelectStereoDrawBuffer', wptr, 0);
			CenterText(wptr, rect, secs_text, color, offset, size);
			Screen('SelectStereoDrawBuffer', wptr, 1);
			CenterText(wptr, rect, secs_text, color, offset, size);
		else
			CenterText(wptr, rect, secs_text, color, offset, size);
        end
        
		Screen('Flip', wptr, GetSecs + .1);
	end
end