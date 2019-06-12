% Initialise
Configure;

% Message to send
msg = [1 1 1 1 1 1 1 1 8 1 8 1 8 1 8 1 2 3 6 7 8 3 1 4 1 5 8 2 6 5 3 5 8 8 7 8 3 2 3 8 4 6 2 6 4 3 3 8 3 2 7 8 1 8 1 8 1];

% Modulation parameters
bottom_freq     = 2000;
baud_rate       = 10;
amplitude       = 0.2;


wav = Modulate(FS, NCARRIERS, baud_rate, bottom_freq, TONE_SPC, msg);
wav = amplitude * wav;

% Plot, play and save the result
% spectrogram(wav, hamming(FFT_SIZE), FFT_OVERLAP, FFT_SIZE);
wf = Waterfall(FS, wav, FFT_SIZE, FFT_SHIFT);
imagesc(wf)
sound(wav, FS);
% audiowrite('modulated.wav', wav, FS);
