function calculate_norms(dataset_prefix, l_values, k_values)

    timestamp = datestr(now, 'yyyymmdd_HHMMSS');
    fileID = fopen(sprintf('results_%s.txt', timestamp), 'w');
    
    for l = l_values
        for k = k_values

            fprintf('Processing dataset: %s, l=%d, k=%d\n', dataset_prefix, l, k);

            s1_path = sprintf('%s/POW_s_k100.mat', dataset_prefix);
            s2_path = sprintf('%s/CoSS_l%dk%d.mat', dataset_prefix, l, k);
            
            try
                load(s1_path, 's_cropped');  
                load(s2_path, 'sl');  
            catch
                fprintf('Error loading files for l=%d, k=%d. Skipping...\n', l, k);
                continue;
            end

            if size(s_cropped, 2) ~= size(sl, 1)
                fprintf('Dimension mismatch for l=%d, k=%d. Skipping...\n', l, k);
                continue;
            end

            delta_s = full(s_cropped) - sl;
            
            delta_s_norm_l2 = norm(delta_s, 2);
            delta_s_norm_max = max(max(abs(delta_s)));

            fprintf(fileID, 'Dataset: %s, l=%d, k=%d\n', dataset_prefix, l, k);
            fprintf(fileID, '  2-norm: %f\n', delta_s_norm_l2);
            fprintf(fileID, '  Max-norm: %f\n\n', delta_s_norm_max);
            
            fprintf('Dataset: %s, l=%d, k=%d\n', dataset_prefix, l, k);
            fprintf('  2-norm: %f\n', delta_s_norm_l2);
            fprintf('  Max-norm: %f\n\n', delta_s_norm_max);
        end
    end
    
    fclose(fileID);
end

l_values = 50:50:1000;
k_values = 10:10:200;

calculate_norms('EE', l_values, k_values);
% calculate_norms('P2P', l_values, k_values);
