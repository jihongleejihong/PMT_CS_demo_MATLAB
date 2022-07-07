function rgb = Lab_ColorWheel(angles, center, radius)
	% default values from Zhang & Luck (2008)
	if ~exist('center', 'var') || isempty(center)  center = [70, 20, 38]; end %#ok<SEPEX>
	if ~exist('radius', 'var') || isempty(radius)  radius = 60; end %#ok<SEPEX>

	[h, w] = size(angles);
	[a, b] = pol2cart(angles / 180 * pi, radius);
	Lab = cat(3, repmat(center(1), h, w), a + center(2), b + center(3));
	rgb = lab2rgb(Lab);
end