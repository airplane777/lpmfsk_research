function [waveform] = Modulate(fs, freq_lower, freq_upper, symbol_duration, message)
% Modulate a message vector to 8-FSK waveform.
  symbol_freq = freq_lower : (freq_upper - freq_lower) / 7 : freq_upper;
  waveform = [];
  message_size = size(message);
  assert(message_size(1) == 1, 'Message is not a row vector.');
  for i = 1 : message_size(2)
    assert(message(i) >= 1 && message(i) <= 8, 'Symbol range overflow.');
    waveform = [waveform, Symbol_Gen(fs, symbol_freq(message(i)), symbol_duration)];
  end;
end
