% Initialise
Configure;

% Modulation parameters
bottom_freq     = 1000;
baud_rate       = 10;   % symbols per second
amplitude       = 0.5;
message_length  = 50;   % symbols

% Generate random message
msg = randi([1 NCARRIERS], 1, message_length);

% Modulate message
wav = Modulate(FS, NCARRIERS, baud_rate, bottom_freq, TONE_SPC, msg);
wav = amplitude * wav;

% Plot spectrogram
wf = Waterfall(FS, wav, FFT_SIZE, FFT_SHIFT);
imagesc(wf)

% Play and save audio
sound(wav, FS);
% id = 1;
% filename = sprintf("%d_f%.2f_br%.2f_amp%.2f.wav", id, bottom_freq, baud_rate, amplitude);
% audiowrite(filename, wav, FS);
