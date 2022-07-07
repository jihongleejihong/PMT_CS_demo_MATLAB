function trect = CenterText(wptr, rect, text, color, offset, size)
	if ~exist('color', 'var')  || isempty(color)  color = [0 0 0]; end %#ok<SEPEX>
	if ~exist('offset', 'var') || isempty(offset) offset = [0 0];  end %#ok<SEPEX>
	if exist('size', 'var') && ~isempty(size)
		oldSize = Screen('TextSize', wptr, size);
	end
	[cx, cy] = RectCenter(rect);
	trect = Screen('TextBounds', wptr, text);
	[thw, thh] = RectCenter(trect);
	tx = cx - thw + offset(1);
	ty = cy - thh + offset(2);
	Screen('DrawText', wptr, double(text), tx, ty, color);
	trect = repmat([cx cy] + offset, 1, 2) + trect;
	if exist('oldSize', 'var') && ~isempty(oldSize)
		Screen('TextSize', wptr, oldSize);
	end
end