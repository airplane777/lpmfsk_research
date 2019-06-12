% Initialise
Configure;

real_audio = audioread('../audio/mixed.wav');
spectrogram(real_audio, hamming(FFT_SIZE), FFT_OVERLAP, FFT_SIZE);