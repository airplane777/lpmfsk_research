% Initialise
Configure;

% Modulation parameters
bottom_freq     = 2000;
amplitude       = 0.5;

% Generate random message and add header pattern
msg = [randi([1 NCARRIERS], 1, MSG_LENGTH)];

% Modulate message
wav = Modulate(FS, NCARRIERS, BAUD_RATE, bottom_freq, TONE_SPC, msg);
wav = amplitude * wav;

% Plot spectrogram
wf = Waterfall(wav, FFT_SIZE, FFT_SHIFT);
imagesc(Amp_To_dB(wf));

% Play and save audio
sound(wav, FS);
% id = id + 1
% filename = sprintf("%d_f%.2f_br%.2f_amp%.2f.wav", id, bottom_freq, BAUD_RATE, amplitude);
% audiowrite(filename, wav, FS);
