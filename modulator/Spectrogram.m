% Initialise
Configure;

real_audio = audioread('../audio/mixed.wav');
wf = Waterfall(FS, real_audio, FFT_SIZE, FFT_SHIFT);

imagesc(wf)