% Run after CFAR

% Parameters
sync_accept_threshold      = 0.900; % Percentage of sync symbol to confirm sync
subcfar_decision_threshold = 3;
buf_size                   = 20;

symbol_length     = FS * (1 / BAUD_RATE) / FFT_SHIFT;
tone_scale        = TONE_SPC * BAUD_RATE / (FS / FFT_SIZE);
tone_scale_centre = round(0.5 * tone_scale);
sync_accept_count = round(sync_accept_threshold * sync_length);
accepted_counter  = 0;
accepted_data     = zeros(DATA_LENGTH, buf_size);
% accepted_frame   = zeros(cell_size(1), cell_size(2), buf_size);

tic;
for i = 1 : wf_size(1) - cell_size(1)
  for j = 1 : wf_size(2) - cell_size(2)
    if snr_map_bin(i, j) == 1
      % 1st stage CFAR detected.
      sync_valid = 0;
      data_demod = zeros(DATA_LENGTH, 1);
      data_demod_ptr = 0;
      sync_demod_ptr = 0;
      freq_offset = 0;
      % Reset LPF
      Slide_LPF(0, true);
      align_i = i;
      for msg_i = 1 : msg_length
        align_i = Constrain(align_i + round(Slide_LPF(freq_offset, false)), ...
                            1, wf_size(1) - tone_scale * NCARRIERS - 1);
        % Select box and do cell integration
        box = wfp(align_i : align_i + tone_scale * NCARRIERS - 1, ...
                  j + (msg_i - 1) * symbol_length : j + msg_i * symbol_length - 1);
        subcfar_result = zeros(NCARRIERS, 1);
        for subcfar_i = 1 : NCARRIERS
          cfar_box = box((subcfar_i - 1) * tone_scale + 1 : subcfar_i * tone_scale, :);
          subcfar_result(subcfar_i) = sum(sum(cfar_box));
        end % NCAR sub-CFAR's
        [subcfar_peak_val, subcfar_peak_loc] = max(subcfar_result);
        % Find frequency offset for next alignment
        align_box = box((subcfar_peak_loc - 1) * tone_scale + 1: subcfar_peak_loc * tone_scale, ...
                        :);
        [align_peak_val, align_peak_loc] = max(sum(align_box, 2));
        freq_offset = align_peak_loc - tone_scale_centre;
        % Box is data or sync?
        if mod(msg_i, (SYNC_INTERVAL + 1)) ~= 1  % Is data symbol, register peak only
          data_demod_ptr = data_demod_ptr + 1;
          data_demod(data_demod_ptr) = subcfar_peak_loc;
        else % Is sync symbol, run CFAR-like detection
          sync_demod_ptr = sync_demod_ptr + 1;
          if subcfar_peak_loc == SYNC_PATTERN(sync_demod_ptr)
            subcfar_mask = subcfar_result;
            subcfar_mask(subcfar_peak_loc) = 0; % Remove maximum
            if subcfar_peak_val >= subcfar_decision_threshold * max(subcfar_mask)
              sync_valid = sync_valid + 1;
            end % If CFAR true
          end % If sync position correct
        end % Data or sync
      end % For each box
      if sync_valid >= sync_accept_count
        % Frame synchronised, save data
        save_flag = true;
        for buf_i = 1 : buf_size
          if isequal(data_demod, accepted_data(:, buf_i))
            save_flag = false;
            break
          end
        end
        if save_flag
          accepted_counter = accepted_counter + 1;
          accepted_data(:, accepted_counter) = data_demod;
        end
%         accepted_frame(:, :, accepted_counter) = wfp(i : i + cell_size(1) - 1, j : j + cell_size(2) - 1);
      end % Save synchronised frame
    end % If CFAR detected
  end
  w = waitbar(i / (wf_size(1) - cell_size(1)));
end % For each pixel

close(w);
toc;
