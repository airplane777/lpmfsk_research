% Initialise
Configure;

% Parameters
decision_threshold = 100;
% bw_threshold = 0.91;

% Generate header template
bottom_freq     = 10000; % Template frequency
template_margin = 2;     % Pixels

top_freq = bottom_freq + (NCARRIERS - 1) * (BAUD_RATE * TONE_SPC);

% Generate template
wav = Modulate(FS, NCARRIERS, BAUD_RATE, bottom_freq, TONE_SPC, HEADER_PATTERN);

header_template = Waterfall(FS, wav, FFT_SIZE, FFT_SHIFT);
header_template = header_template( ...
                                   bottom_freq / (FS / FFT_SIZE) - template_margin : ...
                                   top_freq / (FS / FFT_SIZE) + template_margin, ...
                                   : ...
                                 );

% Regulate template
header_template = mat2gray(header_template);
% header_template = imbinarize(header_template, bw_threshold);

% Check generated template
% imagesc(header_template)

% For debug only
% load header_template.mat;

template_size = size(header_template);
wf_size       = size(wf);
search_range  = wf_size - template_size;
heatmap       = zeros(search_range);

tic;
for i = 1 : search_range(1)
  for j = 1 : search_range(2)
    box = wf(i : i + template_size(1) - 1, j : j + template_size(2) - 1);
    box = mat2gray(box);
    % box = imbinarize(box, bw_threshold);
    heatmap(i, j) = Diff_2d(box, header_template);
  end
  fprintf("Scanning row %d of %d\n", i, search_range(1));
end
toc;

