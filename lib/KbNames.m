function keys = KbNames(varargin)
	keys = [];
	for argin = varargin
		keys = [keys, KbName(argin{:})]; %#ok<AGROW>
	end
end