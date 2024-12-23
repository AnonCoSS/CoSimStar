clear all;

fprintf('Load Graph ...\n');
% load('E:\datasets\.mat')  % wiki-Vote cit-HepPh email-EuAll cit-Patents soc-LiveJournal1
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

l = 50; 
qu = 200;
kmax = 30;
c = 0.6;

n = size(a, 1);

fprintf('Normalising A ...\n');
q = spdiags(1./sum(a,1)', 0, n, n) * a';   % transpose(col_norm(a))
clear a

ts_svd = tic;
fprintf('low rank SVD (a=%d)...\n', l);
[u, si, v] = svds(q, l);

v = v';
fprintf('tensor product...\n');
ku = kron(u,u);
ksi = kron(si,si);
kv = kron(v,v);

fprintf('compute kuv...\n');
kvu = kv*ku;

fprintf('compute la...\n');
la = inv(inv(ksi)-c*kvu);
ii = speye(n);

fprintf('compute vr...\n');
vr = kv*ii(:);

fprintf('compute s...\n');
p = ku*la;
ss = ii(:)+c*p*vr;
s = reshape(ss, n,n);

te_svd = toc(ts_svd);

fprintf('Total Time: \t%f\n', te_svd);

mem_var = whos;
mem = sum([mem_var.bytes]);
fprintf('Memory (bytes) :\t%d\n', mem);
