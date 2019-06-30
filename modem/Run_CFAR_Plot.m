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
  w = waitbar(i / (wf_size(1) - cell_size(1)));
end

close(w);

% Generate histogram
figure;
histogram(wfp);
axis([0 3e-3 0 10000]);

% Plot data
figure;
subplot(2, 2, 1);
imagesc(amp2db(wf));
colorbar;
title("Original Spectrogram");

subplot(2, 2, 2);
imagesc(pwr2db(noise_map));
colorbar;
title("Map of background noise");

subplot(2, 2, 3);
imagesc(amp2db(snr_map));
colorbar;
title("Map of target SNR");

subplot(2, 2, 4);
imagesc(snr_map_bin);
title("CFAR result");
