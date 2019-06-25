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