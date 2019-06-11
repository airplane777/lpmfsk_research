% Initialise
Configure;

% Message to send
msg = [1 8 1 8 1 8 1 8 3 1 4 1 5 8 2 6 5 3 5 8 8 7 8 3 2 3 8 4 6 2 6 4 3 3 8 3 2 7 8 1 8 1 8 1];

% Modulation parameters
bottom_freq     = 3000;
baud_rate       = 20;
amplitude       = 0.5;
fft_size        = 1024;
fft_overlap     = 256;

wav = Modulate(FS, NCARRIERS, baud_rate, bottom_freq, TONE_SPC, msg);
wav = amplitude * wav;

% Plot, play and save the result
spectrogram(wav, hamming(fft_size), fft_overlap, fft_size);
sound(wav, FS);
% audiowrite('modulated.wav', wav, FS);