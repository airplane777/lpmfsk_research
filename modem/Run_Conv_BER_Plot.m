figure
hold on

load('ser_wo_coding.mat');
plot(snr, ser);

load('ser_k5.mat');
plot(snr, ser);

load('ser_k10.mat');
plot(snr, ser);

load('ser_k15.mat');
plot(snr, ser);