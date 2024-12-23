clear all;

fprintf('Load Graph ...\n');
load('../datasets/soc-LiveJournal1.mat') 

a = Problem.A; 
clear Problem

l = 100;   %[50,100,150,200,250]
qu = 200;  %[100,200,300,400,500] soc-LiveJournal 
kmax = 30; %[10,20,30,40,50]
c = 0.6;   

n = size(a, 1);

fprintf('Normalising A ...\n');
q = spdiags(1./sum(a,1)', 0, n, n) * a';   
clear a

ts_whole = tic;
mem_var = whos;
mem_initial = sum([mem_var.bytes]);  % Initial memory

peak_memory = mem_initial;  % Initialize peak memory

% Arnoldi Decomposition
ts_arnoldi = tic;
fprintf('Arnoldi Decomposition (a=%d) ', l);
e = sparse(n,1);
e(1) = 1;
[v, h] = arnoldi(q, e, l);
fprintf('\n');
te_arnoldi = toc(ts_arnoldi);
mem_var = whos('e','v','h','q');
mem_after_arnoldi = sum([mem_var.bytes]);  
mem_arnoldi = max(mem_after_arnoldi - peak_memory, 0);  % Calculate increment
peak_memory = max(peak_memory, mem_after_arnoldi);  % Update peak memory

% Random Sampling
idx = randsample(1:n, qu); 
v = v(idx, 1:l);
h = h(1:l, 1:l);

% Subspace Iteration
ts_subiter = tic;
fprintf('Subspace Iteration (k=%d) ', kmax);
sl = eye(l,l);
for k=1:kmax
    fprintf('.');
    sl = c*h*sl*h' + eye(l,l);
end
fprintf('\n');
te_subiter = toc(ts_subiter);
mem_var = whos('sl','h');
mem_after_subiter = sum([mem_var.bytes]);  
mem_subiter = max(mem_after_subiter - peak_memory, 0);  % Calculate increment
peak_memory = max(peak_memory, mem_after_subiter);  % Update peak memory

% Online Query
ts_query = tic;
fprintf('Online Query ...\n');
sim = v*sl*v';
te_query = toc(ts_query);
mem_var = whos('sim','sl','v');
mem_after_query = sum([mem_var.bytes]);  
mem_query = max(mem_after_query - peak_memory, 0);  % Calculate increment
peak_memory = max(peak_memory, mem_after_query);  % Update peak memory

te_whole = toc(ts_whole);
mem_total = peak_memory - mem_initial;  % Total memory based on peak usage

% Output the timings and memory usage
fprintf('Total Time: \t%f\n', te_whole);
fprintf('  Time (Arnoldi):\t%f\n', te_arnoldi);
fprintf('  Time (Subspace):\t%f\n', te_subiter);
fprintf('  Time (Online Query):\t%f\n', te_query);

fprintf('Total Memory (bytes): \t%d\n', mem_total);
fprintf('  Memory (Arnoldi): \t%d\n', mem_after_arnoldi);
fprintf('  Memory (Subspace): \t%d\n', mem_after_subiter);
fprintf('  Memory (Online Query): \t%d\n', mem_after_query);
