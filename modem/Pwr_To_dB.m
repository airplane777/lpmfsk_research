function [out] = Pwr_To_dB(in)
% Convert power to dB scale
  out = 10 .* log(in);
end

