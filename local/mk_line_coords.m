function [coords, r_mask] = mk_line_coords(n_stim,  area_mask)
% Input = [n_stim, line_width, asp_ratio, margin, anglemat, area_mask]
r_rects = ones(n_stim, 1) * line_width ./2;  % half widths of rectangles: 10 - 25 px
ratio = ones(n_stim, 1) * asp_ratio;    % aspect ratios of rectangles: 1 - 2.5
tilt = anglemat;         % tilt angle of rectangles: 0 - 180 degs.


r_circles = r_rects;  % radii of circles: 5 - 30 px
% mask = mk_shape(map_radial(area_r * 2), area_r);


r_n = 0;

while (n_stim ~= r_n)
    
    
    [c1, m_voidmap, m_n] = random_coords(area_mask, ...
        r_circles + margin ./4, ...  % oval params.
        @postfunc_oval, @prefunc_rect ...
        );
    % occupied areas (inculding margin) are marked with 0 in void map
corr(c1)
    
    [c2, c_voidmap, c_n] = random_coords(area_mask - (m_voidmap .*255), ...
        r_circles ./2, ...  % oval params.
        @postfunc_oval, @prefunc_oval ...
        );
    % occupied areas (inculding margin) are marked with 0 in void map
    
    corr(c2)
    % random coordinates of rectangle centers
    %   1st column of rect. params.: half width + margin
    %   2nd column of rect. params.: aspect ratio (1 if not provided)
    %   3rd column of rect. params.: tilt angle (0 if not provided)
    
    [coords, r_voidmap, r_n] = random_coords(area_mask -((m_voidmap+c_voidmap) .*255), ...
        [r_rects, ratio, tilt], ...  % rect. params.
        @postfunc_rect, @prefunc_rect ...
        );
    
    corr(coords)
end
disp([n_stim, m_n, c_n, r_n])
subplot(1, 4, 1);
imshow(area_mask);
subplot(1, 4, 2);
imshow(area_mask-(m_voidmap .*255));
subplot(1, 4, 3);
imshow(area_mask -((m_voidmap+c_voidmap) .*255));
subplot(1, 4, 4);
imshow(r_voidmap);

r_mask = r_voidmap .* 255;
end