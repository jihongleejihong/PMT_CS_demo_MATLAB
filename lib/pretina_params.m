function varargout = pretina_params(params, varargin)
%PRETINA_PARAMS Sets empty shape parameters to a given default value.
%
%   Used in POSTFUNC_* and PREFUNC_* functions, intended for internal use only.

	n_params = size(params, 2);
	for i = 1:length(varargin)
		if n_params >= i
			varargout{i} = params(i); %#ok<AGROW>
		else
			varargout{i} = varargin{i}; %#ok<AGROW>
		end
	end
end