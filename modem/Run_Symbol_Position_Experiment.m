Select_Frame;

figure
imagesc(pwr2db(testbox))

% Plot symbol separation lines
symbol_length = FS * (1 / BAUD_RATE) / FFT_SHIFT;
for i = 1 : msg_length
  line([i * symbol_length, i * symbol_length], [1, 70], 'color', 'cyan');
end

% Plot tone separation lines
tone_scale = TONE_SPC * BAUD_RATE / (FS / FFT_SIZE);
for i = 1 : NCARRIERS
  line([1, 700], [i * tone_scale, i * tone_scale], 'color', 'cyan');
end

% Plot sub-CFAR detection points
symbol_length = FS * (1 / BAUD_RATE) / FFT_SHIFT;
tone_scale = TONE_SPC * BAUD_RATE / (FS / FFT_SIZE);
for sync_i = 1 : floor(DATA_LENGTH / SYNC_INTERVAL) + 1
  subcfar_i = tone_scale * (SYNC_PATTERN(sync_i) - 1);
  subcfar_j = (SYNC_INTERVAL + 1) * (sync_i - 1) * symbol_length;
  rectangle('Position', [subcfar_j, subcfar_i, symbol_length, tone_scale], 'EdgeColor', 'r');
end

