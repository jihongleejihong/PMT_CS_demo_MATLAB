function make_gabor_pl(wptr, rect, pxpd)
	[cx, cy] = RectCenter(rect);

	tex_size  = 400;
	l_gabor   = 127;
	c_gabor   = [];
	f_gabor   = 1 / 8;	% 1 cycle / 5 deg
	sd_gabor  = (7/60) * pxpd;		% 7 minutes
	stim_pl = ptb.gabor_alpha( ...
		tex_size, [], ...
		l_gabor, ...	% mean luminance
		c_gabor, ...	% contrast
		f_gabor, ...	% spatial freq.
		90, ...			% phase (sine grating)
		0, ...			% tilt angle (sine grating)
		sd_gabor ...	% std. dev
		);
	gtex = Screen('MakeTexture', wptr, stim_pl);

	area_mask = mk_shape(map_radial(400), 5 * pxpd) - mk_shape(map_radial(400), 1 * pxpd);

	n_gabors = 60;
	sd_gabors = ones(1, n_gabors) * sd_gabor;

	gabor_cpairs = util.RandomCoords(area_mask, sd_gabors, @util.PreFuncNull, @util.PostFuncGaussian);
	gabor_rects = pairs2rects(gabor_cpairs, tex_size);
	gabor_rects = moverects(gabor_rects, cx, cy);
	gabor_angles = distnorm(rand(1, n_gabors), 0, 15);		% mean 0 deg., sd 15 deg.

	Screen('DrawTextures', wptr, gtex, [], gabor_rects, gabor_angles);
	Screen('Flip', wptr);
  
	expkey(KbName('space'));
	Screen('CloseAll');
end