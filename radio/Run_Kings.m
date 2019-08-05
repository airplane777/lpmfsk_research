% Constants
c          = 299792458;  % m/s, speed of light(radio)
a          = 6371e3;     % m, Earth radius
f          = 10e6;       % Hz, RF frequency
epsilon_0  = 8.8542e-12; % Electric constant
epsilon_rg = 80;         % Water + NaCl
sigma_g    = 4;          % S/m, water + NaCl

% Calculations
lambda    = c / f;
epsilon_c = epsilon_rg + ((1i * sigma_g) / (2 * pi * f * epsilon_0));

k0 = (2 * pi) / lambda; % In air
kg = k0 * sqrt(abs(epsilon_c)); % On ground


dc = a * (k0 * a / 2) ^ (-1 / 3);
di = (2 * (kg ^ 2)) / (k0 ^ 3);

