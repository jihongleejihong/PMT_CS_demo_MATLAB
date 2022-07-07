function [resp, rt] = expmouse(btndown, refresh, tolerance, timebase, timeout)
	if ~exist('btndown',   'var') || isempty(btndown)   btndown = @(x, y, btns) find(btns); end %#ok<SEPEX>
	if ~exist('refresh',   'var') || isempty(refresh)   refresh = @(x, y, btns) WaitSecs(.002); end %#ok<SEPEX>
	if ~exist('tolerance', 'var') || isempty(tolerance) tolerance = 0; end %#ok<SEPEX>
	if ~exist('timebase',  'var') || isempty(timebase)  timebase = GetSecs; end %#ok<SEPEX>
	if ~exist('timeout',   'var') || isempty(timeout)   timeout = Inf; end %#ok<SEPEX>

	timeout = timebase + timeout;
	while GetSecs < timeout
		[~, ~, keycode] = KbCheck(-3);
		if keycode(27)
			error('user abort: ESC key pressed');
		end

		[x, y, btns] = GetMouse;
		rt = GetSecs - timebase;
		refresh(x, y, btns);
		if any(btns)
			resp = btndown(x, y, btns);
			if ~isempty(resp)
				[x2, y2, b] = deal(x, y, btns);
				while any(b)
					[x2, y2, b] = GetMouse;
				end
				if all(abs([x y] - [x2 y2]) <= tolerance)
					break;
				end
			end
		end
	end
end