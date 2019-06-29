% Binarise SNR map
decision_threshold = 3;
snr_map_bin = zeros(wf_size - cell_size);
for i = 1 : wf_size(1) - cell_size(1)
  for j = 1 : wf_size(2) - cell_size(2)
    if snr_map(i, j) >= decision_threshold
      snr_map_bin(i, j) = 1;
    else
      snr_map_bin(i, j) = 0;
    end
  end
end

% Plot data
figure;
subplot(2, 2, 1);
imagesc(Amp_To_dB(wf));
colorbar;
title("Original Spectrogram");

subplot(2, 2, 2);
imagesc(Pwr_To_dB(noise_map));
colorbar;
title("Map of background noise");

subplot(2, 2, 3);
imagesc(Amp_To_dB(snr_map));
colorbar;
title("Map of target SNR");

subplot(2, 2, 4);
imagesc(snr_map_bin);
title("CFAR result");