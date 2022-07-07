function ap = base_apparatus(screenWidth, screenHeight, frameRate, displayWidth, viewingDistance)
	% initial stuff
	if exist('rng', 'file') == 2
		rng('default');
		rng('shuffle');
	else
		ClockRandSeed;
	end
	clear KbWait;
	KbName('UnifyKeyNames');

	% apparatus
	ap = struct( ...
		'ScreenWidth',     screenWidth, ...
		'ScreenHeight',    screenHeight, ...
		'FrameRate',       frameRate, ...
		'DisplayWidth',    displayWidth, ...
		'ViewingDistance', viewingDistance ...
		);
	ap.mmpd = ap.ViewingDistance * tand(0.5) * 2;
	ap.pxpd = ap.mmpd / ap.DisplayWidth * ap.ScreenWidth;

	% apparatus check
	scr = Screen('Resolution', 0);
	msgs = {};
	if scr.width ~= ap.ScreenWidth
		msgs{end + 1} = sprintf('ScreenWidth: %d px instead of %d px', scr.width, ap.ScreenWidth);
	end
	if scr.height ~= ap.ScreenHeight
		msgs{end + 1} = sprintf('ScreenHeight: %d px instead of %d px', scr.height, ap.ScreenHeight);
	end
	if scr.hz ~= ap.FrameRate
		msgs{end + 1} = sprintf('FrameRate: %d Hz instead of %d Hz', scr.hz, ap.FrameRate);
	end

	if ~isempty(msgs)
		fprintf(2, 'Non-matching apparatus:\n');
		cellfun(@(s) fprintf(2, ' - %s\n', s), msgs);
	end
end