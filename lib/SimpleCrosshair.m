function SimpleCrosshair(wptr, params)
	rect = Screen('Rect', wptr);
	[cx, cy] = RectCenter(rect);
	if ~isfield(params, 'cx')
		params.cx = cx;
	end
	if ~isfield(params, 'cy')
		params.cy = cy;
	end

	if isfield(params, 'or') && isfield(params, 'ir') && isfield(params, 'lc')
		if ~isfield(params, 'lt')
			params.lt = 2;
		end
		or = params.or;
		ir = params.ir;
		Screen('DrawLines', wptr, ...
			[-or, -ir, ir, or,   0,   0,  0,  0; ...
			   0,   0,  0,  0, -or, -ir, ir, or], ...
			params.lt, params.lc, [params.cx, params.cy], 0);
	end
end