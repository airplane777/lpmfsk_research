% Prior knowledge

% Basic
FS         = 44100; % Sampling rate
NCARRIERS  = 8;     % Number of carriers
TONE_SPC   = 8;     % Tone spacing factor
BAUD_RATE  = 10;    % Symbols per second
MSG_LENGTH = 58;    % Length of message(temporary)
GAIN       = 1;     % RX gain

% Transform
FFT_SIZE  = 4410;         % FFT window length
                          % Resolution of waterfall on frequency axis
FFT_SHIFT = 882;          % FFT window shift step
                          % Resolution of waterfall on time axis
TGT_BAND  = [1100 12000]; % Detection target frequency band

% Cross-correlation parameters
HEADER_PATTERN = [1 8 2 7 3 6 4 5];