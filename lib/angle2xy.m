function [xmat, ymat] = angle2xy(varargin)
%ANGLE2XY Generates maps of x- and y-values from angle and eccentricity.
%
%   [XMAT, YMAT] = ANGLE2XY(ANGLES [,ECCS]) returns matrices with the same size
%   as ANGLES and ECCS (eccentricities). XMAT and YMAT contains x- and y-values
%   in the monitor coordinate for the given ANGLES and ECCS.
%
%   Arguments:
%      ANGLES - matrix containing angles in the monitor coordinate.
%      ECCS   - matrix containing eccentricities for corresponding ANGLES,
%         considered as 1 if empty or not provided.
%
%   See also XY2ANGLE.

	angles = pretina_arg(varargin, 1, mfilename, 'angles',  [], {'numeric'}, {'nonempty', 'real', 'finite', 'nonnan'});
	eccs   = pretina_arg(varargin, 2, mfilename, 'lengths', 1,  {'numeric'}, {'nonempty', 'real', 'finite', 'nonnan'});
	if ~isscalar(eccs)
		validateattributes(eccs, {'numeric'}, {'size', size(angles)}, mfilename, 'lengths', 2);
	end

	xmat = cosd(angles - 90) .* eccs;
	ymat = sind(angles - 90) .* eccs;
end