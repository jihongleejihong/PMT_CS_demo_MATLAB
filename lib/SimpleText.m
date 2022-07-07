function trect = SimpleText(wptr, rect, text, color, offset)
	if ~exist('color', 'var')  || isempty(color)  color = [0 0 0]; end %#ok<SEPEX>
	if ~exist('offset', 'var') || isempty(offset) offset = [0 0];  end %#ok<SEPEX>
	[cx, cy] = RectCenter(rect);
	trect = Screen('TextBounds', wptr, text);
	[thw, thh] = RectCenter(trect);
	tx = cx - thw + offset(1);
	ty = cy - thh + offset(2);
	Screen('DrawText', wptr, text, tx, ty, color);
	trect = repmat([cx cy] + offset, 1, 2) + trect;
end