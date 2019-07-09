% Initialise
Configure;

% Modulation parameters
bottom_freq     = 2000;
amplitude       = 0.5;

% Generate random message
data = randi([1 NCARRIERS], 1, DATA_LENGTH);

% Insert synchronise symbols
msg      = [];
msg_ptr  = 0;
data_ptr = 0;
sync_ptr = 0;

while data_ptr < DATA_LENGTH
  msg_ptr = msg_ptr + 1;
  if mod(msg_ptr, (SYNC_INTERVAL + 1)) == 1
    sync_ptr = sync_ptr + 1;
    msg(msg_ptr) = SYNC_PATTERN(sync_ptr);
  else
    data_ptr = data_ptr + 1;
    msg(msg_ptr) = data(data_ptr);
  end
end

% Modulate message
wav = Modulate(FS, NCARRIERS, BAUD_RATE, bottom_freq, TONE_SPC, msg);
wav = amplitude * wav;

% Plot spectrogram
wf = Waterfall(wav, FFT_SIZE, FFT_SHIFT);
imagesc(amp2db(wf));

% Play and save audio
% sound(wav, FS);
% id = id + 1
filename = sprintf("%d_f%.2f_br%.2f_amp%.2f.wav", id, bottom_freq, BAUD_RATE, amplitude);
audiowrite(filename, wav, FS);
