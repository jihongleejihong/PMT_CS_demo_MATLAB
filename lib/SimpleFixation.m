function SimpleFixation(wptr, params)
	rect = Screen('Rect', wptr);
	[cx, cy] = RectCenter(rect);
	if ~isfield(params, 'cx')
		params.cx = cx;
	end
	if ~isfield(params, 'cy')
		params.cy = cy;
	end

	if isfield(params, 'cr') && isfield(params, 'cc')
		Screen('FillOval', wptr, params.cc, ...
			CenterRectOnPoint([0 0 2 2] * params.cr, params.cx, params.cy));
	end
	if isfield(params, 'lr') && isfield(params, 'lc')
		if ~isfield(params, 'lt')
			params.lt = 2;
		end
		Screen('DrawLines', wptr, ...
			[-1 1 0 0; 0 0 -1 1] * params.lr, params.lt, params.lc, ...
			[params.cx, params.cy], 0);
	end
end