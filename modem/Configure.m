% Prior knowledge

% TX
FS        = 44100; % Sampling rate
NCARRIERS = 8;     % Number of carriers
TONE_SPC  = 2;     % Tone spacing factor
BAUD_RATE = 10;    % Symbols per second

% RX
FFT_SIZE  = 4410; % FFT window length
                  % Resolution of waterfall on frequency axis
FFT_SHIFT = 300;  % FFT window shift step
                  % Resolution of waterfall on time axis

% SEARCH
MSG_LENGTH = 50;

% DECODE