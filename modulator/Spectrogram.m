real_audio = audioread('../audio/whitenoise+mod.wav');
spectrogram(real_audio, hamming(fft_size), fft_overlap, fft_size);