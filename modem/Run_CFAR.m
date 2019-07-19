% Initialise
Configure;

% CFAR parameters
cell_margin  = [0.000 0.000]; % Frequency, Time
guard_margin = [0.100 0.050]; % Size of guard/train area multiplied by cell size
train_margin = [0.600 0.200];

wf_size      = size(wf);  % Size of entire waterfall
sync_length = floor(DATA_LENGTH / SYNC_INTERVAL) + 1;
msg_length   = DATA_LENGTH + sync_length;
cell_size    = [1 + floor(TONE_SPC * BAUD_RATE * NCARRIERS / (FS / FFT_SIZE) * (1 + cell_margin(1))) ...
                1 + floor((FS * msg_length) / (FFT_SHIFT * BAUD_RATE) * (1 + cell_margin(2))) ...
               ];
                          % Size of guard/train area in pixels
guard_size   = floor(guard_margin .* cell_size);
train_size   = floor(train_margin .* cell_size);

tic;
% Generate background noise heatmap(power)
fprintf("Computing background noise profile...\n");
bg_window_size = cell_size + 2 .* (guard_size + train_size);
bg_range       = wf_size - bg_window_size;
noise_map      = zeros(bg_range);

for i = 1 : bg_range(1)
  for j = 1 : bg_range(2)
    box = wfp(i : i + bg_window_size(1) - 1, j : j + bg_window_size(2) - 1);
    box(train_size(1) : train_size(1) + 2 * guard_size(1) + cell_size(1) - 1, train_size(2) : train_size(2) + 2 * guard_size(2) + cell_size(2) - 1) ...
    = zeros(2 .* guard_size + cell_size);
    noise_map(i, j) = sum(sum(box));
  end
  if mod(i, 10) == 0
    w = waitbar(i / bg_range(1));
  end
end
noise_map = noise_map ./ (bg_window_size(1) * bg_window_size(2) - (bg_window_size(1) - train_size(1)) * (bg_window_size(2) - train_size(2)));

% Generate SNR map(ratio)
fprintf("Generating SNR map...\n");
snr_map = zeros(wf_size - cell_size);
cell_area = cell_size(1) * cell_size(2);

for i = 1 : wf_size(1) - cell_size(1)
  for j = 1 : wf_size(2) - cell_size(2)
    box = wfp(i : i + cell_size(1) - 1, j : j + cell_size(2) - 1);
    snr_map(i, j) = sum(sum(box));
    nmap_pos(1) = Constrain(i - guard_size(1) - train_size(1), 1, bg_range(1));
    nmap_pos(2) = Constrain(j - guard_size(2) - train_size(1), 1, bg_range(2));
    snr_map(i, j) = snr_map(i, j) ./ (cell_area .* noise_map(nmap_pos(1), nmap_pos(2)));
  end
  if mod(i, 10) == 0
    w = waitbar(i / (wf_size(1) - cell_size(1)));
  end
end

close(w);
toc;
