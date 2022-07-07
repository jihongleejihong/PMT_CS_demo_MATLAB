function DrawCrosshair(wptr, rect, or, ir, c)
	[cx, cy] = RectCenter(rect);
	l = [-or, -ir, ir, or,   0,   0,  0,  0; ...
		   0,   0,  0,  0, -or, -ir, ir, or];
	Screen('DrawLines', wptr, l, 4, c, [cx, cy], 1);
end