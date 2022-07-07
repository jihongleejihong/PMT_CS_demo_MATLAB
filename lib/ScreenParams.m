function [pxpd, mmpd] = ScreenParams(varargin)
	assert(mod(nargin, 3) == 0, 'arguments should be pairs of hostname, viewing distance and monitor width in millimeters');

	[r, hostname] = system('hostname');
	assert(r == 0, 'cannot determine hostname of this computer');
	hostname = strtrim(hostname);

	this = find(~cellfun(@isempty, strfind(varargin(1:3:end), hostname)), 1);
	if isempty(this)
		this = find(~cellfun(@isempty, strfind(varargin(1:3:end), 'default')), 1);
	end
	assert(~isempty(this), sprintf('this computer (%s) is not defined', hostname));

	s = Screen('Resolution', max(Screen('Screens')));
	vd = varargin{this * 3 - 1};
	mw = varargin{this * 3};
	mmpd = tand(.5) * vd * 2;
	pxpd = mmpd / mw * s.width;
end