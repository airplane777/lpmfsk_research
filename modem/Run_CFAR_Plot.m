% Analyse data
% Parameters
peak_search_size = 200; % pixels

figure;
imagesc(wf);
ntgt = 0;
for i = peak_search_size + 1 : wf_size(1) - peak_search_size
  for j = peak_search_size + 1 : wf_size(2) - peak_search_size
    detected_flag = true;
    for mask_i = i - peak_search_size : i + peak_search_size
      for mask_j = j - peak_search_size : j + peak_search_size
        if wf(mask_i, mask_j) > wf(i, j)
          detected_flag = false;
          break
        end
      end
      if detected_flag == false
        break
      end
    end
    if detected_flag == true
      ntgt = ntgt + 1;
      rectangle('Position', [j , i , cell_size(2), cell_size(1)], 'EdgeColor', 'r')
    end
  end
  w = waitbar(i / (wf_size(1) - peak_search_size));
end

close(w);

% Plot data

figure;
subplot(2, 2, 1);
imagesc(wf);
title("Original Spectrogram");

subplot(2, 2, 2);
imagesc(noise_map);
title("Map of background noise");

subplot(2, 2, 3);
imagesc(snr_map);
title("Map of target SNR");

subplot(2, 2, 4);
mesh(snr_map);
title("3D view of target SNR");