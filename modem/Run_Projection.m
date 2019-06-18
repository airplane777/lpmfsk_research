% Run after variable wf is generated.

smooth_length = 70;
wf_size = size(wf);
int_time = zeros(wf_size(1), 1);
int_freq = zeros(wf_size(2), 1);

for i = 1 : wf_size(1)
    for j = 1 : wf_size(2)
        int_time(i) = int_time(i) + wf(i, j);
    end
end

for j = 1 : wf_size(2)
    for i = 1 : wf_size(1)
        int_freq(j) = int_freq(j) + wf(i, j);
    end
end

subplot(2, 2, 1)
imagesc(wf)
title('Spectrogram')

subplot(2, 2, 2)
plot(int_time)
xlim([1 wf_size(1)])
view([90 90])
title('Projection on frequency axis')

subplot(2, 2, 4)
plot(int_freq)
xlim([1 wf_size(2)])
title('Projection on time axis')

int_freq_smooth = smoothdata(int_freq, 'movmean', smooth_length);

subplot(2, 2, 3)
plot(int_freq_smooth)
xlim([1 wf_size(2)])
title('Projection on time axis(smoothed)')

