% Run after CFAR finished

accepted_counter = 0;
accepted_frame = zeros(cell_size(1), cell_size(2), 100);

% Parameters
loc_var_threshold = 0.500;
min_peak_height = 0.1;

for i = 1 : wf_size(1) - cell_size(1)
  for j = 1 : wf_size(2) - cell_size(2)
    if snr_map_bin(i, j) == 1
      % Select box
      box = wfp(i: i + cell_size(1) - 1, j: j + cell_size(2) - 1);
      % Time integration
      proj = zeros(cell_size(1), 1); % Allocate projection vector
      for box_i = 1 : cell_size(1)
        for box_j = 1 : cell_size(2)
          proj(box_i) = proj(box_i) + box(box_i, box_j);
        end
      end % Integration finished
      % Peak detection
      [peak_vals, peak_locs] = findpeaks(proj, 'npeaks', NCARRIERS, 'sortstr', 'descend');
      % Make decision
      peak_locs_size = size(peak_locs);
      % Count peaks above threshold
      npeak = 0;
      for peak_i = 1 : peak_locs_size
        if peak_vals(peak_i) >= min_peak_height * max(peak_vals)
          npeak = npeak + 1;
        end
      end
      if npeak == NCARRIERS
        peak_locs = sort(peak_locs);
        delta = zeros(NCARRIERS - 1, 1);
        for delta_i = 1 : NCARRIERS - 1
          delta(delta_i) = peak_locs(delta_i + 1) - peak_locs(delta_i);
        end % Calculate delta loc
        loc_var = var(delta); % Calculate delta loc variance
        if loc_var <= loc_var_threshold % ACCEPT!
          accepted_counter = accepted_counter + 1;
          accepted_frame(:, :, accepted_counter) = box(:, :);
        end % If varience satisfied
      end % If NCAR peaks detected
    end % If CFAR detected
  end
  w = waitbar(i / (wf_size(1) - cell_size(1)));
end % For each pixel

close(w);

