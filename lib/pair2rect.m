function rect = pair2rect(pair, width, height)
	if ~exist('height', 'var') || isempty(height) height = width; end %#ok<SEPEX>
	rect = pairs2rects(pair', width, height)';
end