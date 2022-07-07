function ap = Jeonil(viewingDistance)
	if ~exist('viewingDistance', 'var') viewingDistance = 600; end %#ok<SEPEX>
	ap = base_apparatus( ...
			1600, ...  % ScreenWidth:     1600 px
			1200, ...  % ScreenHeight:    1200 px
			85, ...    % FrameRate:       85 Hz
			400, ...   % DisplayWidth:    400 mm
			viewingDistance);
end