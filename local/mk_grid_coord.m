function coords = mk_grid_coord(n, interval, jitter)

if (rem(sqrt(n), 1) ~= 0) || (n <= 0)
    disp('please insert n as a square number')
end

sg_row =  (0:sqrt(n)-1) * interval;

[X, Y] = meshgrid(sg_row- max(sg_row) / 2, sg_row- max(sg_row) / 2);

base_coords = [X(1:end)', Y(1:end)'];

coords = -jitter + 2 * jitter * (rand(size(base_coords))) + base_coords(randperm(length(base_coords)), :);

end