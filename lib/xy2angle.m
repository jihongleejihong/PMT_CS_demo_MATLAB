function angle = xy2angle(x, y)
	%angle = mod(atan2d(y, x) + 90, 360);
	angle = mod(atan2(y, x) / pi * 180 + 90, 360);	% workaround for old MATLAB
end