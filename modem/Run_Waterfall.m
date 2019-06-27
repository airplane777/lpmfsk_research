% Initialise
Configure;

% Load audio file
% real_audio = audioread('../signal/mixed.wav');
real_audio = audioread('../dataset/gen_3/snr_mid.wav');

% Convert stereo into mono(for recorded files)
real_audio_size = size(real_audio);
if real_audio_size(2) > 1
  real_audio = real_audio(:, 1);
end

% Compute spectrogram
wf = Waterfall(FS, real_audio, FFT_SIZE, FFT_SHIFT);

% Keep target band only
wf = wf(TGT_BAND(1) / (FS / FFT_SIZE) : TGT_BAND(2) / (FS / FFT_SIZE), :);

imagesc(wf)
