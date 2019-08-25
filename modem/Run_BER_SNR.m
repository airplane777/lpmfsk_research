Configure;
load('tgtm.mat');

% First modulate a message
Run_Modulate;
wav = [zeros(1, 4410) wav zeros(1, 8820)];

snr = -50 : 1 : 10;
snr_size = size(snr);
ser = zeros(1, snr_size(2));
trials = 30;

% Generate a binary sequence
tgtm_bin = oct2gray(tgtm);

% Plot uncoded curve
for p = 1 : snr_size(2)
  for pt = 1 : trials
    wavn = awgn(wav, snr(p));
    wf = Waterfall(wavn, FFT_SIZE, FFT_SHIFT);
    wfp = wf .^ 2;
    Run_Sync_Search;
    rx_bin = oct2gray(accepted_data);
    ser(p) = ser(p) + Count_Errors(rx_bin, tgtm_bin);
  end
end

ser = ser ./ (153 * trials);

plot(snr, ser);









