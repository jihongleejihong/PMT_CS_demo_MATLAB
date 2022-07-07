function ScreenConstraints(varargin)
	assert(mod(nargin, 3) == 0, 'arguments should be pairs of hostname, screen resolution and refresh rate');

	[r, hostname] = system('hostname');
	assert(r == 0, 'cannot determine hostname of this computer');
	hostname = strtrim(hostname);

	this = find(~cellfun(@isempty, strfind(varargin(1:3:end), hostname)), 1);
	if ~isempty(this)
		s = Screen('Resolution', max(Screen('Screens')));
		sr = varargin{this * 3 - 1};
		rr = varargin{this * 3};
		assert(all([s.width, s.height] == sr), sprintf('set screen resolution to %dpx by %dpx', sr(1), sr(2)));
		assert(s.hz == rr, sprintf('set refresh rate to %dHz', rr));
	end
end