testbox_position = [449 1395];

testbox = wfp(testbox_position(1) : testbox_position(1) + cell_size(1), ...
  testbox_position(2) : testbox_position(2) + cell_size(2));

figure
imagesc(testbox)

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
