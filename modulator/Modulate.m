function [waveform] = Modulate(fs, ncarriers, freq_lower, freq_upper, symbol_duration, message)
% Modulate a message vector to M-FSK waveform.
  symbol_freq = freq_lower : (freq_upper - freq_lower) / (ncarriers - 1) : freq_upper;
  message_size = size(message);
  waveform = [];
  assert(message_size(1) == 1, 'Message is not a row vector.');
  for i = 1 : message_size(2)
    assert(message(i) >= 1 && message(i) <= ncarriers, 'Symbol range overflow.');
    waveform = [waveform, Symbol_Gen(fs, symbol_freq(message(i)), symbol_duration)];
  end;
end
