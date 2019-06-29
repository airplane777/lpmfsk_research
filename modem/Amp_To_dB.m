function [out] = Amp_To_dB(in)
% Convert amplitude to dB scale
  out = 20 .* log(in);
end

