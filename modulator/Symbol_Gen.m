function [waveform] = Symbol_Gen(fs, freq, duration)
% Return a waveform vector containing modulated symbol.
  persistent phase;
  if isempty(phase)
    phase = 0;
  end
  time = 0 : 1 / fs : duration;
  waveform = sin(2 * pi * freq * (time + phase));
  phase = asin(waveform(end));
end

