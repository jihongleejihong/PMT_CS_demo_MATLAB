function [M, estim_r] = mk_corr_vectors(n, mu, sigma, target_r, disttype, tol)

% Input:
% n: the number of generated items
% mu: [mu of d1, mu of d2]
% sigma: [sd of d1, sd of d2]
% r: target correlation coefficient
% tol: tolerance of estimated r (abs(estimed_r - target_r)) / default = % 1e-05
% dist: type of distribution where item is sampled ('unif', 'norm') /
% default = 'unif'

%% this function was edited based on
% http://www.talkstats.com/threads/r-matlab-generating-correlating-normal-variates.23135/

%% tolerance of estimation
if ~exist('tol') || isempty(tol)  tol = 1e-05; end %#ok<SEPEX>
if ~exist('dist') || isempty(disttype)  disttype = 'unif'; end %#ok<SEPEX>

%% the number of feature dimensions
d= 2;    
    
estim_r = 100; % start_val

while abs(estim_r - target_r) > tol

if disttype == 'unif'
% create uncorrelated observations
X = rand(n, d);
elseif disttype == 'norm'
X = randn(n, d);
end

% % check X
% figure;
% plotmatrix(X); corrcoef(X);

% set correlation matrix
R = ones(d, d) * target_r;
R(1:(d + 1):(d * d)) = 1;

% compute cholesky factor
cF = chol(R);

% induce correlation, check
Y = X * cF;
% figure
% plotmatrix(Y); corrcoef(Y)

% transform with means and sd's, check
x = distnorm(Y(:, 1), mu(1), sigma(1));
y = distnorm(Y(:, 2), mu(2), sigma(2));
M = [x, y];
% figure
% plotmatrix(M);  corrcoef(M);

estim_r = corr(x, y);
end

end
