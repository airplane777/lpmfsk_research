function [wfall2d] = Waterfall(waveform, window_size, window_shift)
% Generate 2D waterfall diagram(spectrogram) of given sequence

  window = hamming(window_size); % Hamming window
%   window = ones(window_size, 1); % Square window
  
  ncycles = floor(length(waveform) / window_shift) - floor(window_size / window_shift);
  wfall2d = zeros(window_size, ncycles);
  waveform_size = size(waveform);
  assert(xor(waveform_size(1) == 1, waveform_size(2) == 1), 'Waveform is not a vector.');
  if waveform_size(1) == 1
    waveform = waveform';
  end

  for i = 1 : ncycles
    subseq_start = (i - 1) * window_shift + 1;
    subseq_end = subseq_start + window_size - 1;
    wfall2d(:, i) = abs(fft(window .* waveform(subseq_start: subseq_end)));
    w = waitbar(i / ncycles);
  end

  wfall2d = wfall2d(1: floor(window_size / 2), :);
  wfall2d = Normalise(wfall2d);
  
  close(w);
end

