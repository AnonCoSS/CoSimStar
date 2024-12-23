clear all;
fprintf('Load Graph ...\n');
load('../Datasets/soc-sign-bitcoin-otc.mat') % Load dataset
G = Problem.A; 
clear Problem

% Set parameters
c = 0.6;
epsilon = 0.1;
p_f = 0.1;
delta = 0.025;

% Call RPCS function
tic
S_hat = rpcs(G, c, epsilon, p_f, delta);
toc

% Output memory usage
mem_var = whos;
mem = sum([mem_var.bytes]);
fprintf('Memory (bytes) :\t%d\n', mem);

% RPCS Function Definition
function S_hat = rpcs(a, c, epsilon, p_f, delta)
    n = size(a, 1);
    fprintf('Normalising A ...\n');
    q = spdiags(1./sum(a,1)', 0, n, n) * a';
    clear a

    % Step 1: Calculate number of iterations t
    kmax = ceil(log(1 - c - (1 - c) * epsilon) / log(c) / (c * (1 - delta)));
    fprintf("kmax=%d\n", kmax);
    
    % Step 2: Calculate reduced dimension d
    d = ceil(2 * log(n^2 / (2 * p_f)) / (delta - log(1 + delta)));
    fprintf("dim_(d)=%d\n", d);
    
    % Step 3: Check if reduced dimension d is greater than or equal to n
    if d >= n
        Q = q;
    else
        % Generate random matrix T and calculate Q
        T = randn(n, d);
        Q = (1 / sqrt(d)) * (q * T);
    end
    
    % Initialize H and S_hat
    fprintf("initialize H ...\n");
    H = sqrt(c) * Q;
    fprintf("initialize S_hat ...\n");
    S_hat = speye(n) + H * H';
    
    % Iterative update of S_hat
    fprintf("iteration S_hat ");
    for k = 2:kmax
        fprintf(".");
        H = sqrt(c) * (q * H);
        S_hat = S_hat + H * H';
    end
    fprintf("\n");
end
