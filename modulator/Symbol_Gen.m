function [waveform] = Symbol_Gen(fs, freq, duration)
% Return a waveform vector containing modulated symbol.
  persistent phase; % Static variable for phase relationship management
  if isempty(phase)
    phase = 0; % Initial phase
  end
  time = 0 : 1 / fs : duration - 1 / fs;
  waveform = sin(2 * pi * freq * time + phase);
  phase = asin(sin(2 * pi * freq * duration + phase)); % No sudden phase change
end

