band1_f   = 10 .^ [4.0 4.2 4.4 4.5 4.6 4.7];
band1_fa  =       [148 127 105 97  90  86];

band2_f   = 10 .^ [4.7 4.8 4.9 5.0 5.2 5.4 5.5 5.6 5.7 5.8 5.9 6.0 6.2 6.4 6.5];
band2_fa  =       [86  84  83  81  73  65  62  60  57  56  55  54  45  36  35];

band3_f   = 10 .^ [6.5 6.6 6.7 6.8 6.9 7.0 7.2 7.4 7.5 7.6 7.7 7.8 7.9 8.0];
band3_fa  =       [35  35  34  32  31  30  24  16  15  13  11  10  9   8];

band_f   = [band1_f band2_f band3_f];
band_f_log = log10(band_f);
band_fa  = [band1_fa band2_fa band3_fa];

[noise, gof] = Noise_Fit(band_f_log, band_fa);

figure
semilogx(band_f, band_fa);
grid on;
