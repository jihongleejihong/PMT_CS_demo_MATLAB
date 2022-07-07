function rects = pairs2rects(pairs, widths, heights)
	if ~exist('heights', 'var') || isempty(heights) heights = widths; end %#ok<SEPEX>
	n_pairs = size(pairs, 2);
	if isscalar(widths)
		widths = repmat(widths, 1, n_pairs);
	end
	if isscalar(heights)
		heights = repmat(heights, 1, n_pairs);
	end
	rects = pairs - round([widths; heights] / 2);
	rects = [rects; rects + [widths; heights]];
end