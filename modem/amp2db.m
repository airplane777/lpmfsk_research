function [out] = amp2db(in)
% Convert amplitude to dB scale
  out = 20 .* log10(in);
end

