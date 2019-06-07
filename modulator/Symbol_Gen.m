function [waveform] = Symbol_Gen(fs, freq, duration)
% Return a waveform vector containing modulated symbol.
  time = 0 : 1 / fs : duration;
  waveform = sin(2 * pi * freq * time);
end

