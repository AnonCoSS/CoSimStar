function run_experiment(dataset_path, dataset_save_prefix, k)
    % clear all;
    fprintf('Load Graph from %s ...\n', dataset_path);
    load(dataset_path);  % Load the specified dataset
    a = Problem.A; 
    clear Problem

    % Load query indices based on dataset prefix and k
    idx_file = sprintf('%s/k%d_idx.mat', dataset_save_prefix, k);
    fprintf('Loading query index from %s\n', idx_file);
    load(idx_file);  % Load saved index
    qu = numel(idx);  % Get size of indices

    % Initialize variables
    c = 0.6;  % Damping factor

    % Get the number of nodes n
    n = size(a, 1);

    fprintf('Normalising A ...\n');
    q = spdiags(1 ./ sum(a, 1)', 0, n, n) * a';  % Normalize adjacency matrix
    clear a

    % Begin power iteration
    ts_iter = tic;
    fprintf('Power Iteration (k=%d) ', k);
    s = speye(n, n);
    qt = q';
    for i = 1:k
        fprintf('.');
        s = c * q * s * qt + speye(n, n);
    end
    fprintf('\n');

    % Get dimensions of s
    [s_hat_rows, s_hat_cols] = size(s);
    fprintf('S_hat size: %d rows, %d columns\n', s_hat_rows, s_hat_cols);

    % Crop matrix s using idx
    s_cropped = s(idx, idx);

    % Save cropped s matrix to file
    save_file = sprintf('%s/POW_s_k%d.mat', dataset_save_prefix, k);
    fprintf('Saving cropped matrix to %s\n', save_file);
    save(save_file, 's_cropped');  % Save cropped matrix as .mat file

    % Output dimensions of cropped matrix
    [s_cropped_rows, s_cropped_cols] = size(s_cropped);
    fprintf('Cropped s size: %d rows, %d columns\n', s_cropped_rows, s_cropped_cols);

    % Output elapsed time
    te_iter = toc(ts_iter);
    fprintf('Total Time for Power Iteration: %f seconds\n', te_iter);
end

% Run for the EE dataset
run_experiment('../Datasets/email-Eu-core.mat', 'EE', 100);

% Run for the P2P dataset
% run_experiment('../Datasets/p2p-Gnutella08.mat', 'P2P', 200);
