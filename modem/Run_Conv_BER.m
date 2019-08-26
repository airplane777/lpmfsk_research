% Now add channel coding. Convert message to binary
load('tgtm.mat');
tgtm_bin = oct2gray(tgtm);

% Setup trellis
trellis = poly2trellis(15, [66432 51323 32655]);

% Conv it!
code = convenc(tgtm_bin, trellis);

% Map to 8-FSK
tgtm = gray2oct(code); % tgtm length 153

% Perform BER-SNR test
Run_Modulate;
wav = [zeros(1, 4410) wav zeros(1, 8820)];

snr = -19 : 0.1 : -14;
snr_size = size(snr);
ser = zeros(1, snr_size(2));
trials = 300;

tic
for p = 1 : snr_size(2)
  for pt = 1 : trials
    wavn = awgn(wav, snr(p));
    wf = Waterfall(wavn, FFT_SIZE, FFT_SHIFT);
    wfp = wf .^ 2;
    Run_Sync_Search;
    rx_bin = oct2gray(accepted_data);
    rx_decode = vitdec(rx_bin, trellis, 150, 'trunc', 'hard');
    ser(p) = ser(p) + Count_Errors(rx_decode, tgtm_bin);
  end
  w = waitbar(p / snr_size(2));
end
toc

ser = ser ./ (153 * trials);

plot(snr, ser);
close(w);