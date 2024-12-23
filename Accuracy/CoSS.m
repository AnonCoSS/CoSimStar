function run_experiment(dataset_path, dataset_save_prefix, l, kmax)

    fprintf('Load Graph from %s ...\n', dataset_path);
    load(dataset_path);  % Load specified dataset

    a = Problem.A; 
    clear Problem

    c = 0.6;  % Fixed value

    n = size(a, 1);
    fprintf('Normalising A ...\n');
    q = spdiags(1./sum(a,1)', 0, n, n) * a';  % Normalization
    clear a

    ts_whole = tic;
    ts_arnoldi = tic;
    fprintf('Arnoldi Decomposition (l=%d) ', l);
    e = sparse(n,1);
    e(1) = 1;
    % Add the path to the arnoldi.m file
    addpath('../Time and Memory/');
    [v, h] = arnoldi(q, e, l);
    rmpath('../Time and Memory/');

    qu = 200;  % Fixed sampling value
    idx = randsample(1:n, qu); 
    save(sprintf('%s/k%d_idx.mat', dataset_save_prefix, kmax), 'idx');  % Save index file
    v = v(idx, 1:l);
    h = h(1:l, 1:l);
    fprintf('\n');
    te_arnoldi = toc(ts_arnoldi);

    ts_subiter = tic;
    fprintf('Subspace Iteration (k=%d) ', kmax);
    sl = eye(l,l);
    for k=1:kmax
        fprintf('.');
        sl = c*h*sl*h' + eye(l,l);
    end

    sl = v * sl * v';  % Resulting sl is qu x qu
    save(sprintf('%s/CoSS_l%dk%d.mat', dataset_save_prefix, l, kmax), 'sl');  % Save result file
    [s_hat_rows, s_hat_cols] = size(sl);
    fprintf('S_hat size: %d rows, %d columns\n', s_hat_rows, s_hat_cols);

    te_subiter = toc(ts_subiter);
    te_whole = toc(ts_whole);

    % Output time information
    fprintf('Total Time: \t%f\n', te_whole);
    fprintf('  Time (Arnoldi):\t%f\n', te_arnoldi);
    fprintf('  Time (Subspace):\t%f\n', te_subiter);

end

% Run for email-Eu-core dataset, l=50, k=10
run_experiment('../Datasets/email-Eu-core.mat', 'EE', 100, 100);

% Run for p2p-Gnutella08 dataset, l=100, k=50
% run_experiment('../Datasets/p2p-Gnutella08.mat', 'P2P', 100, 200);
