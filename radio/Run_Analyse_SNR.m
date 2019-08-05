FREQ_RANGE = 1e6 : 0.5e6 : 30e6; % Hz
DIST_RANGE = 100 : 10 : 5000;   % m
P_TX       = +11;                % dBm
G_TX       = -40;                % dBi
G_RX       = +3;                 % dBi
BW         = 400;                % Hz

% Malloc
db_signal = zeros(size(FREQ_RANGE, 2), size(DIST_RANGE, 2));
db_noise  = zeros(size(FREQ_RANGE, 2), 1);
freq_range_size = size(FREQ_RANGE);
dist_range_size = size(DIST_RANGE);

% Predict signal power(dBm)
for f = 1 : freq_range_size(2)
  for d = 1 : dist_range_size(2)
    db_signal(f, d) = Friis(P_TX, G_TX, G_RX, DIST_RANGE(d), FREQ_RANGE(f)); % dBm
  end
end

% Predict noise power(dBm)
Gen_Noise; % Run ITU data curve fitting
for f = 1 : freq_range_size(2)
  db_noise(f) = fa(log10(FREQ_RANGE(f))) + 10 * log10(BW) - 204; % dBW
end
db_noise = db_noise + 30; % Convert dBW -> dBm

% Process SNR
pwr_signal = 10 .^ (db_signal ./ 10);
pwr_noise  = 10 .^ (db_noise  ./ 10);
snr = 10 * log10(pwr_signal ./ pwr_noise);

% Plot results
figure;
mesh(DIST_RANGE, FREQ_RANGE, snr);
xlabel('Distance(m)');
ylabel('Frequency(Hz)');
zlabel('SNR(dB)');

figure;
hold on;
for d = 1 : 80 : dist_range_size(2)
  plot(FREQ_RANGE, snr(:, d));
  text(FREQ_RANGE(round(freq_range_size(2) / 2)), ...
       snr(round(freq_range_size(2) / 2), d), ...
       num2str(DIST_RANGE(d)) ...
      );
end
xlabel('Frequency(Hz)');
ylabel('SNR(dB)');


