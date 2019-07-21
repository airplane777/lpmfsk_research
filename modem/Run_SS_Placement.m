% Modulation parameters
bottom_freq     = 1000;
amplitude       = 0.2;

% Generate sync pattern
% TODO: For each sync pattern, try with different data arrangements

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