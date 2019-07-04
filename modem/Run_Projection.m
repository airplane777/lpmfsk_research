% testbox_position = [616 260]; % Quiet
testbox_position = [135 755];

testbox = wfp(testbox_position(1) : testbox_position(1) + cell_size(1), ...
  testbox_position(2) : testbox_position(2) + cell_size(2));

% testbox = accepted_frame(:, :, 2);

testbox_size = size(testbox);
int_time = zeros(testbox_size(1), 1);
int_freq = zeros(testbox_size(2), 1);

for i = 1 : testbox_size(1)
  for j = 1 : testbox_size(2)
    int_time(i) = int_time(i) + testbox(i, j);
  end
end

[peak_int_vals, peak_int_locs] = findpeaks(int_time, 'npeaks', NCARRIERS, 'sortstr', 'descend');
peak_int_locs_size = size(peak_int_locs);
for j = 1 : testbox_size(2)
  for i = 1 : peak_int_locs_size(1)
    int_freq(j) = int_freq(j) + testbox(peak_int_locs(i), j);
  end
end

subplot(2, 2, 1)
imagesc(testbox)
title('Spectrogram')

subplot(2, 2, 2)
plot(int_time)
xlim([1 testbox_size(1)])
view([90 90])
title('Projection on frequency axis')

subplot(2, 2, 3)
plot(int_freq)
xlim([1 testbox_size(2)])
title('Projection on time axis')

subplot(2, 2, 4)
findpeaks(int_time, 'npeaks', NCARRIERS, 'sortstr', 'descend');
title('Peak detection')

% Test demodulation
demod_waveform = zeros(1, testbox_size(2));
for j = 1 : testbox_size(2)
  [peak_demod_val, peak_demod_loc] = max(testbox(:, j));
  demod_waveform(j) = peak_demod_loc;
end

figure
hold on;
axis manual;
imagesc(pwr2db(testbox));
axis([0 wf_size(2) 0 wf_size(1)]);
plot(demod_waveform, 'Color', 'red');
axis([0 testbox_size(2) 0 testbox_size(1)]);
hold off;
