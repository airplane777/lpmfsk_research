% Initialise
Configure;

% Drift parameters A * sin(W * x) + K * x
drift_a = 5;
drift_w = 1e-2;
drift_k = 5e-4;

% Load audio file
real_audio = audioread('../dataset/gen_4/mixed.wav');

% Convert stereo into mono(for recorded files)
real_audio_size = size(real_audio);
if real_audio_size(2) > 1
  real_audio = real_audio(:, 1);
end

% Compute spectrogram
wf = Waterfall(real_audio, FFT_SIZE, FFT_SHIFT);

% Keep target band only
wf = wf(TGT_BAND(1) / (FS / FFT_SIZE) : TGT_BAND(2) / (FS / FFT_SIZE), :);
wf = GAIN .* wf;

% Make it drift!
wf = Make_Drift(wf, drift_a, drift_w, drift_k);

wfp = wf .^ 2;

imagesc(amp2db(wf));
