% Run after CFAR

% Parameters
sync_accept_threshold      = 0.800; % Percentage of sync symbol to confirm sync
subcfar_decision_threshold = 2;
subcfar_margin             = 1;     % Frequency axis only

symbol_length = FS * (1 / BAUD_RATE) / FFT_SHIFT;
tone_scale    = TONE_SPC * BAUD_RATE / (FS / FFT_SIZE);
subcfar_delta = subcfar_margin * tone_scale;

accepted_counter = 0;
accepted_frame   = zeros(cell_size(1), cell_size(2), 100);

for i = 1 : wf_size(1) - cell_size(1)
  for j = 1 : wf_size(2) - cell_size(2)
    if snr_map_bin(i, j) == 1
      % CFAR detected, for each sync symbol
      sync_valid = 0;
      for sync_i = 1 : sync_length
        subcfar_i = i + tone_scale * (SYNC_PATTERN(sync_i) - 1);
        subcfar_j = j + (SYNC_INTERVAL + 1) * (sync_i - 1) * symbol_length;
        % Estimate target
        box = wfp(subcfar_i : subcfar_i + tone_scale - 1, subcfar_j : subcfar_j + symbol_length - 1);
        signal_level = sum(sum(box));
        % Estimate noise
        box = wfp(subcfar_i - subcfar_margin * tone_scale : subcfar_i - 1, subcfar_j : subcfar_j + symbol_length - 1); % Lower band
        noise_level = sum(sum(box));
        box = wfp(subcfar_i + tone_scale : subcfar_i + tone_scale + subcfar_margin * tone_scale - 1, subcfar_j : subcfar_j + symbol_length - 1); % Upper band
        noise_level = noise_level + sum(sum(box));
        % Make decision
        if signal_level * 2 * subcfar_margin / noise_level >= subcfar_decision_threshold
          sync_valid = sync_valid + 1;
        end % Sub-CFAR counter
      end % For each synchronisation symbols
      if sync_valid / sync_length >= sync_accept_threshold
        % Frame synchronised
        accepted_counter = accepted_counter + 1;
        accepted_frame(:, :, accepted_counter) = wfp(i : i + cell_size(1) - 1, j : j + cell_size(2) - 2);
      end % Save synchronised frame
    end % If CFAR detected
  end
  w = waitbar(i / (wf_size(1) - cell_size(1)));
end % For each pixel

close(w);

