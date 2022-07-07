function coords = polygonal_coords(sides, radius, tilt, x_jitter_r, y_jitter_r)


% sides = Number of sides for our polygon, radius = radius of polygon


% Angles at which our polygon vertices endpoints will be. We start at zero
% and then equally space vertex endpoints around the edge of a circle. The
% polygon is then defined by sequentially joining these end points.
anglesDeg = linspace(0, 360, sides + 1);
anglesRad = anglesDeg * (pi / 180);


% X and Y coordinates of the points defining out polygon, centred on the
% centre of the screen
yPosVector = sin(anglesRad) .* radius;
xPosVector = cos(anglesRad) .* radius;
coords = [xPosVector; yPosVector]';
coords = coords(1:end-1,:);

[coords(:, 1), coords(:, 2)] = rotate_xy(coords(:,1), coords(:, 2), tilt);
jitter_mat = [- x_jitter_r + (x_jitter_r + x_jitter_r) * rand(length(coords), 1), ...
                        - y_jitter_r + (y_jitter_r + y_jitter_r) * rand(length(coords), 1)];
coords = jitter_mat + coords;
end