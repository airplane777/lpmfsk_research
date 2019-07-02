testbox_position = [1095 467];
% testbox_position = [525 1230];

testbox = wfp(testbox_position(1): testbox_position(1) + cell_size(1), ...
  testbox_position(2): testbox_position(2) +cell_size(2));

smooth_length = 70;
testbox_size = size(testbox);
int_time = zeros(testbox_size(1), 1);
int_freq = zeros(testbox_size(2), 1);

for i = 1 : testbox_size(1)
  for j = 1 : testbox_size(2)
    int_time(i) = int_time(i) + testbox(i, j);
  end
end

for j = 1 : testbox_size(2)
  for i = 1 : testbox_size(1)
    int_freq(j) = int_freq(j) + testbox(i, j);
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
[peak_vals, peak_locs] = findpeaks(int_time, 'npeaks', NCARRIERS, 'sortstr', 'descend');
title('Peak detection')

