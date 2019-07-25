function [sidelobe] = SS_GA_Loss(sync_pattern)
  % Modulation parameters
  FS            = 44100;         % Sampling rate
  NCARRIERS     = 8;             % Number of carriers
  TONE_SPC      = 8;             % Tone spacing factor
  BAUD_RATE     = 10;            % Symbols per second
  DATA_LENGTH   = 50;            % Length of message(temporary)
  SYNC_INTERVAL = 3;             % Data symbols between sync symbols
  FFT_SIZE      = 4410;          % FFT window length
                                 % Resolution of waterfall on frequency axis
  FFT_SHIFT     = 441;           % FFT window shift step
                                 % Resolution of waterfall on time axis
  bottom_freq    = 4000;
  amplitude_s    = 0.5;
  awgn_snr       = 20;
  subcfar_margin = 0.700;        % Frequency axis only
  ntestmsg       = 5;

  cell_margin   = [0.000 0.000]; % Frequency, Time
  sync_length   = floor(DATA_LENGTH / SYNC_INTERVAL) + 1;
  msg_length    = DATA_LENGTH + sync_length;
  symbol_length = FS * (1 / BAUD_RATE) / FFT_SHIFT;
  tone_scale    = TONE_SPC * BAUD_RATE / (FS / FFT_SIZE);
  subcfar_delta = round(subcfar_margin * tone_scale);
  cell_size     = [1 + floor(TONE_SPC * BAUD_RATE * NCARRIERS / (FS / FFT_SIZE) * (1 + cell_margin(1))) ...
    1 + floor((FS * msg_length) / (FFT_SHIFT * BAUD_RATE) * (1 + cell_margin(2))) ...
    ];

  % Initialise sidelobe
  sidelobe = 0;

  % Test with N messages
  for testmsg_i = 1 : ntestmsg
    % Generate random message
    data = randi([1 NCARRIERS], 1, DATA_LENGTH);

    % Insert synchronise symbols
    msg      = zeros(1, msg_length);
    msg_ptr  = 0;
    data_ptr = 0;
    sync_ptr = 0;

    while data_ptr < DATA_LENGTH
      msg_ptr = msg_ptr + 1;
      if mod(msg_ptr, (SYNC_INTERVAL + 1)) == 1
        sync_ptr = sync_ptr + 1;
        msg(msg_ptr) = sync_pattern(sync_ptr);
      else
        data_ptr = data_ptr + 1;
        msg(msg_ptr) = data(data_ptr);
      end
    end

    % Modulate message
    wav = Modulate(FS, NCARRIERS, BAUD_RATE, bottom_freq, TONE_SPC, msg);
    wav = amplitude_s * wav;

    % Pad wav with zeros
    wav_size = size(wav);
    pad = zeros(1, wav_size(2));
    wav = [pad wav pad];

    % Add noise
    wav = awgn(wav, awgn_snr);

    % Generate waterfall
    wf = Waterfall(wav, FFT_SIZE, FFT_SHIFT);
    wf = wf(bottom_freq / (FS / FFT_SIZE) - cell_size(1) - subcfar_delta : bottom_freq / (FS / FFT_SIZE) + 2 * cell_size(1) + subcfar_delta, :);
    wf_size = size(wf);
    wfp = wf .^ 2;
    % imagesc(amp2db(wf));

    sub_snr = zeros(wf_size(1) - cell_size(1) - 2 * subcfar_delta, wf_size(2) - cell_size(2));
    % Calculate sidelobe power
    for i = 1 + subcfar_delta : wf_size(1) - cell_size(1) - subcfar_delta
      for j = 1 : wf_size(2) - cell_size(2)
        for sync_i = 1 : sync_length
          subcfar_i = i + tone_scale * (sync_pattern(sync_i) - 1);
          subcfar_j = j + (SYNC_INTERVAL + 1) * (sync_i - 1) * symbol_length;
          % Estimate target
          box = wfp(subcfar_i : subcfar_i + tone_scale - 1, subcfar_j : subcfar_j + symbol_length - 1);
          signal_level = sum(sum(box));
          % Estimate noise
          box = wfp(subcfar_i - subcfar_delta : subcfar_i - 1, subcfar_j : subcfar_j + symbol_length - 1); % Lower band
          noise_level_l = sum(sum(box));
          box = wfp(subcfar_i + tone_scale : subcfar_i + tone_scale + subcfar_delta - 1, subcfar_j : subcfar_j + symbol_length - 1); % Upper band
          noise_level_h = sum(sum(box));
          % Add result to sidelobe
          sub_snr(i - subcfar_delta, j) = signal_level * 2 / (noise_level_l + noise_level_h);
        end % For each sync symbol
      end
    end % For each pixel
    sidelobe = sidelobe - (max(max(sub_snr)) - mean(mean(sub_snr)));
  end % For each test message
  sidelobe = sidelobe;
end

