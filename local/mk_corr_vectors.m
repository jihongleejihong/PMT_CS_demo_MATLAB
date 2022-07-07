function [M, estim_r, disttype] = mk_corr_vectors(n, mu, sigma, target_r, disttype, tol)


% Input:
% [M, estim_r, disttype] = mk_corr_vectors(n, mu, sigma, target_r, disttype, tol)
% n: the number of generated items
% mu: [mu of d1, mu of d2]
% sigma: [sd of d1, sd of d2]
% r: target correlation coefficient
% tol: tolerance of estimated r (abs(estimed_r - target_r)) / default = % 1e-04
% dist: type of distribution where item is sampled ('unif', 'norm') /
% default = 'unif'

%% this function was edited based on
% http://www.talkstats.com/threads/r-matlab-generating-correlating-normal-variates.23135/

%% tolerance of estimation
if ~exist('tol') || isempty(tol)  tol = 1e-04; end %#ok<SEPEX>
if ~exist('disttype') || isempty(disttype)  disttype = 'unif'; end %#ok<SEPEX>

%% the number of feature dimensions
d= 2;    
    
estim_r = 100; % start_val
Rho = [1, target_r; target_r, 1];
while abs(estim_r - target_r) > tol
    X = mvnrnd([0 0], Rho, n);
    Y = normcdf(X,0,1);
if disttype == 'unif'
    Y = unifinv(Y,0,1);
elseif disttype == 'norm'
    Y = norminv(Y,0,1);
end

% transform with means and sd's, check
x = distnorm(Y(:, 1), mu(1), sigma(1));
y = distnorm(Y(:, 2), mu(2), sigma(2));
M = [x, y];
% figure
% plotmatrix(M);  corrcoef(M);

estim_r = corr(x, y);
end

end