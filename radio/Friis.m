function [p_rx] = Friis(p_tx, g_tx, g_rx, d, f)
  C = 299792458; % Speed of light
  p_rx = p_tx + g_tx + g_rx + 20 * log10(C / (4 * pi * d * f));
end

