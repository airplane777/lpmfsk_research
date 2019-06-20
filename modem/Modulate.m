function [waveform] = Modulate(fs, ncarriers, baud_rate, bottom_freq, tone_spacing, message)
% Modulate a message vector to M-FSK waveform.
  symbol_freq = bottom_freq : baud_rate * tone_spacing : bottom_freq + (ncarriers - 1) * (baud_rate * tone_spacing);
  message_size = size(message);
  waveform = [];
  symbol_duration = (1 / baud_rate);
  assert(message_size(1) == 1, 'Message is not a row vector.');
  for i = 1 : message_size(2)
    assert(message(i) >= 1 && message(i) <= ncarriers, 'Symbol range overflow.');
    next_symbol = Symbol_Gen(fs, symbol_freq(message(i)), symbol_duration);
    waveform = [waveform, next_symbol];
  end
end
