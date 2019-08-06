% Constants
c          = 299792458;  % m/s, speed of light(radio)
a          = 6371e3;     % m, Earth radius
epsilon_0  = 8.8542e-12; % Electric constant
epsilon_rg = 80;         % Water + NaCl
sigma_g    = 4;          % S/m, water + NaCl
current    = 0.01;       % A, antenna current at centre
he         = 0.1;        % m, antenna half length

FREQ_RANGE = 1e6 : 0.5e6 : 30e6; % Hz
freq_range_size = size(FREQ_RANGE);
dc = zeros(1, freq_range_size(2));
di = zeros(1, freq_range_size(2));

for i = 1 : freq_range_size(2)
  f         = FREQ_RANGE(i);
  lambda    = c / f;
  epsilon_c = epsilon_rg + ((1i * sigma_g) / (2 * pi * f * epsilon_0));

  k0 = (2 * pi) / lambda; % In air
  kg = k0 * sqrt(abs(epsilon_c)); % On ground

  dc(i) = a * (k0 * a / 2) ^ (-1 / 3);
  di(i) = (2 * (kg ^ 2)) / (k0 ^ 3);
end

figure;
hold on;
plot(FREQ_RANGE, dc);
plot(FREQ_RANGE, di);


