% Initialise
Configure;

% CFAR parameters
wf_size      = size(wf); % Size of entire waterfall
header_size  = size(HEADER_PATTERN);
guard_margin = [0.5 0.25];    % Size of guard/train area multiplied by cell size
train_margin = [1 0.5];
cell_size    = [floor(TONE_SPC * BAUD_RATE * NCARRIERS / (FS / FFT_SIZE)) ...
                floor((FS * (MSG_LENGTH + header_size(2))) / (FFT_SHIFT * BAUD_RATE)) ...
               ];
                         % Size of guard/train area in pixels
guard_size   = floor(guard_margin .* cell_size);
train_size   = floor(train_margin .* cell_size);

% Generate background noise heatmap
fprintf("Computing background noise profile...\n");
bg_window_size = cell_size + 2 .* (guard_size + train_size);
bg_range       = wf_size - bg_window_size;
noise_map      = zeros(bg_range);

for i = 1 : bg_range(1)
  for j = 1 : bg_range(2)
    box = wf(i : i + bg_window_size(1) - 1, j : j + bg_window_size(2) - 1);
    box(train_size(1) : train_size(1) + 2 .* guard_size(1) + cell_size(1) - 1, train_size(2) : train_size(2) + 2 .* guard_size(2) + cell_size(2) - 1) ...
    = zeros(2 .* guard_size + cell_size);
    noise_map(i, j) = Int_2D(box);
  end
  if mod(i, 10) == 0
    fprintf("Scanning row %d of %d\n", i, bg_range(1));
  end
end
noise_map = noise_map ./ (bg_window_size(1) * bg_window_size(2) - (bg_window_size(1) - train_size(1)) * (bg_window_size(2) - train_size(2)));


