% Run after CFAR finished

% Parameters
loc_var_threshold = 0.500;
min_peak_int_height = 0.100;
time_sync_kavg = 0.100;

accepted_counter = 0;
accepted_frame = zeros(cell_size(1), cell_size(2), 100);
cell_centre = round(cell_size(1) / 2);

for i = 1 : wf_size(1) - cell_size(1)
  for j = 1 : wf_size(2) - cell_size(2)
    if snr_map_bin(i, j) == 1
      % Select box
      box = wfp(i: i + cell_size(1) - 1, j: j + cell_size(2) - 1);
      % Time integration
      proj_t = zeros(cell_size(1), 1); % Allocate projection vector
      for box_i = 1 : cell_size(1)
        for box_j = 1 : cell_size(2)
          proj_t(box_i) = proj_t(box_i) + box(box_i, box_j);
        end
      end % Integration finished
      % Peak detection
      [peak_int_vals, peak_int_locs] = findpeaks(proj_t, 'npeaks', NCARRIERS, 'sortstr', 'descend');
      % Make decision
      peak_int_locs_size = size(peak_int_locs);
      % Count peak_ints above threshold
      npeak_int = 0;
      for peak_int_i = 1 : peak_int_locs_size
        if peak_int_vals(peak_int_i) >= min_peak_int_height * max(peak_int_vals)
          npeak_int = npeak_int + 1;
        end
      end
      if npeak_int == NCARRIERS
        peak_int_locs = sort(peak_int_locs);
        delta = zeros(NCARRIERS - 1, 1);
        for delta_i = 1 : NCARRIERS - 1
          delta(delta_i) = peak_int_locs(delta_i + 1) - peak_int_locs(delta_i);
        end % Calculate delta loc
        loc_var = var(delta); % Calculate delta loc variance
        if loc_var <= loc_var_threshold % All carriers in frame, now check if they are centred
          if round(mean(peak_int_locs)) == cell_centre % Frequency synchronised
            fprintf("-");
            proj_f = zeros(cell_size(2), 1); % Allocate projection vector
            for box_j = 1 : cell_size(2) % Projection on freq axis using NCAR-pixel thin matrix
              for box_i = 1 : NCARRIERS
                proj_f(box_j) = proj_f(box_j) + box(peak_int_locs(box_i), box_j);
              end
            end
            proj_f_threshold = time_sync_kavg * mean(proj_f);
            % Count time margin in frame
            time_margin = zeros([1, 2]);
            % Left side
            for box_j = 1 : cell_size(2)
              if proj_f(box_j) <= proj_f_threshold
                time_margin(1) = time_margin(1) + 1;
              else
                break
              end
            end
            % Right side
            for box_j = 1 : cell_size(2)
              if proj_f(cell_size(2) - box_j + 1) <= proj_f_threshold
                time_margin(2) = time_margin(2) + 1;
              else
                break
              end
            end
            if abs(time_margin(1) - time_margin(2)) <= 1
              fprintf("#");
              accepted_counter = accepted_counter + 1;
              accepted_frame(:, :, accepted_counter) = box(:, :);
            end % If time synchoronised
          end % If centred
        end % If varience satisfied
      end % If NCAR peaks detected
    end % If CFAR detected
  end % For each row
  w = waitbar(i / (wf_size(1) - cell_size(1)));
end % For each pixel

close(w);

