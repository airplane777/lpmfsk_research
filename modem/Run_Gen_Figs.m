figure
subplot(1, 2, 1)
plot(wav(52730 : 53130), 'color', 'k')
xlim([0 400])

wav_nomem = wav;
wav_nomem(52730 + 178 : 53130 + 178) = wav(52730 + 192 : 53130 + 192);

subplot(1, 2, 2)
plot(wav_nomem(52730 : 53130), 'color', 'k')
xlim([0 400])

