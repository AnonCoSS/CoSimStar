clear all;

fprintf('Load Graph ...\n');
% load('E:\datasets\email-EuAll.mat')  % wiki-Vote cit-HepPh email-EuAll cit-Patents soc-LiveJournal1
load('../Datasets/soc-sign-bitcoin-otc.mat') % p2p-Gnutella08 wiki-Vote cit-HepPh email-EuAll cit-Patents soc-LiveJournal1

a = Problem.A; 
clear Problem

% a=[ 0, 1, 0, 0, 0, 1, 0, 
%     0, 0, 0, 0, 0, 0, 0, 
%     1, 1, 0, 1, 0, 0, 0, 
%     0, 0, 0, 0, 0, 0, 0, 
%     0, 0, 0, 1, 0, 0, 1, 
%     0, 0, 1, 1, 1, 0, 0, 
%     0, 0, 0, 1, 0, 0, 0];

% l = 100; 
qu = 200;
kmax = 30;
c = 0.6;

n = size(a, 1);

fprintf('Normalising A ...\n');
q = spdiags(1./sum(a,1)', 0, n, n) * a';   % transpose(col_norm(a))
clear a

ts_iter = tic;
fprintf('Power Iteration (k=%d) ', kmax);
s = speye(n,n);
qt = q';
for k=1:kmax
    fprintf('.');
    s = c*q*s*qt + speye(n,n);
end
% s 
% s\hat=
fprintf('\n');
te_iter = toc(ts_iter);

fprintf('Total Time: \t%f\n', te_iter);

mem_var = whos;
mem = sum([mem_var.bytes]);
fprintf('Memory (bytes) :\t%d\n', mem);
