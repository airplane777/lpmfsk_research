Configure;

% First modulate a message
Run_Modulate;
wav = [zeros(1, 4410) wav zeros(1, 4410)];

snr = -50 : 1 : 10;
snr_size = size(snr);
ser = zeros(1, snr_size(2));
trials = 10;

for p = 1 : snr_size(2)
  for pt = 1 : trials
    wavn = awgn(wav, snr(p));
    wf = Waterfall(wavn, FFT_SIZE, FFT_SHIFT);
    wfp = wf .^ 2;
    Run_Sync_Search;
    ser(p) = ser(p) + Count_Errors(accepted_data, tgtm);
  end
end

ser = ser ./ (50 * trials);

plot(snr, ser);