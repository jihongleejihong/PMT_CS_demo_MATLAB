function ws = basews(wptr, rect) %#ok<*INUSL,*ASGLU,*NASGU>
	[cx, cy] = RectCenter(rect);
	cpair = [cx, cy];
	crect = repmat(cpair, 1, 2);
	crects = @(n) repmat(crect', 1, n);

	% put local vars into workspace
	vars = who;
	ws = struct();
	for i = 1:length(vars)
		varname = vars{i};
		ws.(vars{i}) = eval(vars{i});
	end
end