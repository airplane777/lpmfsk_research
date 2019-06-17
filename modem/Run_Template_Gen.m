% Generate waterfall header pattern (global variable)

bottom_freq = 10000;
bw_threshold = 0.9;

top_freq = bottom_freq + (NCARRIERS - 1) * (BAUD_RATE * TONE_SPC);

% Modulate header pattern
wav = Modulate(FS, NCARRIERS, BAUD_RATE, bottom_freq, TONE_SPC, HEADER_PATTERN);

header_template = Waterfall(FS, wav, FFT_SIZE, FFT_SHIFT);
header_template = header_template(bottom_freq / (FS / FFT_SIZE) : top_freq / (FS / FFT_SIZE), :);

header_template = imbinarize(header_template, bw_threshold);

% Check generated template
imagesc(header_template)