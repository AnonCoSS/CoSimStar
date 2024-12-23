clear;  % Clear workspace

fprintf('Loading Graph from edge list...\n');

% Load the eu-2015-host.mat file
load('../../../datasets/eu-2015-host.mat');  % Assumes file contains variable "edges"
% uk-2002.mat

% Ensure edge indices are positive
edges = edges(edges(:,1) > 0 & edges(:,2) > 0, :);

% Get the number of nodes (assuming nodes are numbered from 1 to the max index)
n = max(max(edges));

% Convert edge list to a sparse adjacency matrix
A = sparse(edges(:,1), edges(:,2), 1, n, n);

% Store the adjacency matrix in a structure format compatible with eu-2015-host.mat
Problem.A = A;

% Save the new MAT file (e.g., eu-2015-host format)
save('../../../datasets/eu-2015-host_converted.mat', 'Problem',  '-v7.3');  % Save as structure


fprintf('Conversion complete. Saved as email-EuAll_converted.mat.\n');

