function [rkey, rt] = expkey(keys, forWhat, timebase, timeout)
	if ~exist('forWhat',  'var') || isempty(forWhat)  forWhat = 3; end %#ok<SEPEX>
	if ~exist('timebase', 'var') || isempty(timebase) timebase = GetSecs; end %#ok<SEPEX>
	if ~exist('timeout',  'var') || isempty(timeout)  timeout = Inf; end %#ok<SEPEX>
	RestrictKeysForKbCheck(unique([keys, 27]));
	try
		[secs, keycode] = KbWait(-3, forWhat, timebase + timeout);
		if keycode(27) == 1 % ESC
			error('user abort: ESC key pressed');
		end
		rkey = find(keycode(keys));
		rt = secs - timebase;
		RestrictKeysForKbCheck([]);
	catch e
		RestrictKeysForKbCheck([]);
		rethrow(e);
	end
end