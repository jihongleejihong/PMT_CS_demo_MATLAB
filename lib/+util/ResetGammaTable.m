function ResetGammaTable()
	if exist('ResetGammaTable', 'file') == 2
		ResetGammaTable();
	else
		Screen('LoadNormalizedGammaTable', 0, repmat(linspace(0, 255 / 256, 256)', 1, 3));
	end
end