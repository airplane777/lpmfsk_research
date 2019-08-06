WORST_CASE_NOISE = true;

if WORST_CASE_NOISE
  band2_f   = 10 .^ [4.7 4.8 4.9 5.0 5.2 5.4 5.5 5.6 5.7 5.8 5.9 6.0 6.2 6.4 6.5];
  band2_fa  =       [146 144 142 140 129 117 114 110 106 104 102 100 85  68  61];

  band3_f   = 10 .^ [6.5 6.6 6.7 6.8 6.9 7.0 7.2 7.4 7.5 7.6 7.7 7.8 7.9 8.0];
  band3_fa  =       [61  55  52  47  45  42  24  16  15  13  11  10  9   8];
else
  band2_f   = 10 .^ [4.7 4.8 4.9 5.0 5.2 5.4 5.5 5.6 5.7 5.8 5.9 6.0 6.2 6.4 6.5];
  band2_fa  =       [86  84  83  81  73  65  62  60  57  56  55  54  45  36  35];

  band3_f   = 10 .^ [6.5 6.6 6.7 6.8 6.9 7.0 7.2 7.4 7.5 7.6 7.7 7.8 7.9 8.0];
  band3_fa  =       [35  35  34  32  31  30  24  16  15  13  11  10  9   8];
end; % If use worst case


band_f   = [band2_f band3_f];
band_f_log = log10(band_f);
band_fa  = [band2_fa band3_fa];

[fa, gof] = Noise_Fit(band_f_log, band_fa);

% figure
% semilogx(band_f, band_fa);
% grid on;

