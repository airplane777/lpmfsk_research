% Prior knowledge

% Basic
FS          = 44100; % Sampling rate
NCARRIERS   = 8;     % Number of carriers
TONE_SPC    = 8;     % Tone spacing factor
BAUD_RATE   = 10;    % Symbols per second
DATA_LENGTH = 153;    % Length of message(temporary)
GAIN        = 1;     % RX gain

% Synchronisation
SYNC_INTERVAL = 3; % Data symbols between sync symbols
SYNC_PATTERN  = [1 3 8 1 6 4 2 7 5 3 4 5 7 2 4 3 1 8 2 4 7 6 1 3 8 1 6 4 2 7 5 3 4 5 7 2 4 3 1 8 2 4 7 6 1 3 8 1 6 4 2 7 5 3 4 5 7 2 4 3 1 8 2 4 7 6 1 3 8 1 6 4 2 7 5 3 4 5 7 2 4 3 1 8 2 4 7 6 1 3 8 1 6 4 2 7 5 3 4 5 7 2 4 3 1 8 2 4 7 6 1 3 8 1 6 4 2 7 5 3 4 5 7 2 4 3 1 8 2 4 7 6 ];

% Transform
FFT_SIZE  = 4410;         % FFT window length
                          % Resolution of waterfall on frequency axis
FFT_SHIFT = 441;          % FFT window shift step
                          % Resolution of waterfall on time axis
TGT_BAND  = [1300 9300];  % Detection target frequency band

