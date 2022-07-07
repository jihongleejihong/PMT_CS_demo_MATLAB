function noise_adaptor(ws, pxpd, area, duration)
numrects = 1; %number of random patches per frame 
rectSize = 5 * pxpd;
scale = 1.5;


try
    % 'objrect' is a rectangle of the size 'rectSize' by 'rectSize' pixels of
    % our Matlab noise image matrix:
    objrect = Setrect(0,0, rectSize, rectSize);

    % Arrangerects creates 'numrects' copies of 'objrect', all nicely
    % arranged / distributed in our window of size 'winrect':
    dstrect = Arrangerects(numrects.rects, objrect, rect);

    % Now we rescale all rects: They are scaled in size by a factor 'scale':
    for i=1:numrects.rects
        % Compute center position [xc,yc] of the i'th rectangle:
        [cx, cy] = rectCenter(dstrect(i,:));
        % Create a new rectange, centered at the same position, but 'scale'
        % times the size of our pixel noise matrix 'objrect':
        dstrect(i,:)=CenterrectOnPoint(objrect * scale, cx, cy);
    end

    % Init framecounter to zero and take initial timestamp:
    count = 0;    
    tstart = GetSecs;

    % Run noise image drawing loop for 1000 frames:
    while count < 600
        % Generate and draw 'numrects' noise images:
        for i=1:numrects.rects
            % Compute noiseimg noise image matrix with Matlab:
            % Normally distributed noise with mean 128 and stddev. 50, each
            % pixel computed independently:
            noiseimg=(50*randn(rectSize, rectSize) + 128);

            % Convert it to a texture 'tex':
            tex=Screen('MakeTexture', wptr, noiseimg);

            % Draw the texture into the screen location defined by the
            % destination rectangle 'dstrect(i,:)'. If dstrect is bigger
            % than our noise image 'noiseimg', PTB will automatically
            % up-scale the noise image. We set the 'filterMode' flag for
            % drawing of the noise image to zero: This way the bilinear
            % filter gets disabled and replaced by standard nearest
            % neighbour filtering. This is important to preserve the
            % statistical independence of the noise pixels in the noise
            % texture! The default bilinear filtering would introduce local
            % correlations when scaling is applied:
            Screen('DrawTexture', wptr, tex, [], dstrect(i,:), [], 0);

            % After drawing, we can discard the noise texture.
            Screen('Close', tex);
        end
        
        % Done with drawing the noise patches to the backbuffer: Initiate
        % buffer-swap. If 'asyncflag' is zero, buffer swap will be
        % synchronized to vertical retrace. If 'asyncflag' is 2, bufferswap
        % will happen immediately -- Only useful for benchmarking!
               Screen('Flip', wptr, 0);

        % Increase our frame counter:
        count = count + 1;
    end

    % We're done: Output average framerate:
    telapsed = GetSecs - tstart;
    updaterate = count / telapsed;
    
    % Done. Close Screen, release all ressouces:
%     expkey(KbName('space'));
%     Screen('CloseAll');
catch
    % Our usual error handler: Close screen and then...
    Screen('CloseAll');
    % ... rethrow the error.
    psychrethrow(psychlasterror);
end

end