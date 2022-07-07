function ApplyGammaTable(varargin)
	if exist('ApplyGammaTable', 'file')
		ApplyGammaTable(varargin{:});
	else
		Screen('LoadNormalizedGammaTable', 0, repmat(linspace(0, 255 / 256, 256)' .^ (1/2.2), 1, 3));
	end
end