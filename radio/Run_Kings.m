% Constants
c          = 299792458;  % m/s, speed of light(radio)
a          = 6371e3;     % m, Earth radius
mu_0       = 1.2566e-6;  % Magnetic constant
epsilon_0  = 8.8542e-12; % Electric constant
epsilon_rg = 80;         % Water + NaCl
sigma_g    = 4;          % S/m, water + NaCl
current    = 0.005;       % A, antenna current at centre
he         = 0.1;        % m, antenna half length

FREQ_RANGE      = 4e6 : 1e6 : 30e6; % Hz
freq_range_size = size(FREQ_RANGE);
DIST_RANGE      = 100 : 50 : 10000; % m
dist_range_size = size(DIST_RANGE);
BW              = 400;              % Hz

% Malloc
dc       = zeros(1, freq_range_size(2));
di       = zeros(1, freq_range_size(2));
b        = zeros(freq_range_size(2), dist_range_size(2));
e        = zeros(freq_range_size(2), dist_range_size(2));
snr      = zeros(freq_range_size(2), dist_range_size(2));
db_noise = zeros(1, freq_range_size(2));
db_signal = zeros(1, freq_range_size(2));

% Run ITU data curve fitting
Gen_Noise;

for i = 1 : freq_range_size(2)
  % Phase 0, preparation
  f         = FREQ_RANGE(i);
  lambda    = c / f;
  epsilon_c = epsilon_rg + ((1i * sigma_g) / (2 * pi * f * epsilon_0));
  % Phase 1, compute wavenumber for region 1(land) and 2(air)
  k2 = (2 * pi) / lambda; % In air
  k1 = k2 * sqrt(abs(epsilon_c)); % On ground
  % Phase 2, compute characteristic distances
  dc(i) = a * (k2 * a / 2) ^ (-1 / 3);
  di(i) = (2 * (k1 ^ 2)) / (k2 ^ 3);
  % Phase 3, compute noise level at this frequency
  db_noise(i) = fa(log10(FREQ_RANGE(i))) + 10 * log10(BW) - 204 + 30; % dBm
  % Phase 4, compute attenuation
  for j = 1 : dist_range_size(2)
    d = DIST_RANGE(j);
    if d > dc % In spherical range
      b(i, j) = nil;
    elseif d < di % In plannar range, near area
      b(i, j) = - ((1i * k2 * mu_0 * current * he) / (2 * pi)) * ...
                      ((exp(1i * k2 * d)) / (d));
      else % In plannar range, far area
        b(i, j) = ((mu_0 * k1 ^ 2 * current * he) / (2 * pi * k2 ^ 2)) * ...
                  ((exp(1i * k2 * d)) / (d ^ 2));
    end
    % Convert E to dBm
    e(i, j) = abs((-2 * pi * f / k1) * b(i, j));
    db_signal(i, j) = 20 .* log10(e(i, j)) + 30;
    % Compute SNR
    snr(i, j) = db_signal(i, j) - db_noise(i);
  end % For j(freq)
end % For i(dist)

figure;
hold on;
plot(FREQ_RANGE, dc);
plot(FREQ_RANGE, di);

figure;
mesh(DIST_RANGE, FREQ_RANGE, snr);
% axis([DIST_RANGE(1) DIST_RANGE(end) FREQ_RANGE(1) FREQ_RANGE(end)]);
xlabel('Distance(m)');
ylabel('Frequency(Hz)');
zlabel('SNR(dB)');
