function [int_mat, m, stdev] = int_choice(n_ind, m, sd)


mat = distnorm(rand(n_ind, 1), m, sd);


    int_mat = round(mat);
if mean(int_mat) ~= mean(mat)
    dev = mean(mat) - mean(int_mat);
    k = randi([1,n_ind]);
    int_mat(k) = int_mat(k) + dev * n_ind;

end
int_mat = double(int64(int_mat));
stdev = std(int_mat);

end