% Initialise
Configure;

% Modulation parameters
bottom_freq     = 700;
amplitude       = 0.4;

% Generate random message and add header pattern
msg = [HEADER_PATTERN, randi([1 NCARRIERS], 1, MSG_LENGTH)];

% Modulate message
wav = Modulate(FS, NCARRIERS, BAUD_RATE, bottom_freq, TONE_SPC, msg);
wav = amplitude * wav;

% Plot spectrogram
wf = Waterfall(FS, wav, FFT_SIZE, FFT_SHIFT);
imagesc(wf)

% Play and save audio
sound(wav, FS);
% id = 1;
% filename = sprintf("%d_f%.2f_br%.2f_amp%.2f.wav", id, bottom_freq, BAUD_RATE, amplitude);
% audiowrite(filename, wav, FS);
