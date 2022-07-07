function jitter_mat = mk_jitter_mat(x_dist_max, y_dist_max, row)

x_jitter = - x_dist_max + (x_dist_max + x_dist_max) * rand(row, 1);
y_jitter = - y_dist_max + (y_dist_max + y_dist_max) * rand(row, 1);

jitter_mat = [x_jitter, y_jitter];

end


