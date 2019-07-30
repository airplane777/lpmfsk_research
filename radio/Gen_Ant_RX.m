% Define plot frequency 
plotFrequency = 6780000;
% Define frequency range 
freqRange = (4000:500:14000) * 1e3;
% Define antenna 
antennaObject = monopole_antennaDesigner;

% figure;
% show(antennaObject) 
% % azimuth for monopole
% figure;
% patternAzimuth(antennaObject, plotFrequency) 
% % s11 for monopole
% figure;
% s = sparameters(antennaObject, freqRange); 
% rfplot(s) 
% % impedance for monopole
% figure;
% impedance(antennaObject, freqRange) 
% % pattern for monopole
% figure;
% pattern(antennaObject, plotFrequency) 

% calculate frequency vs gain
freqRange_size = size(freqRange);
maxGain = zeros(1, freqRange_size(2));
for i = 1 : freqRange_size(2)
  [pat, azimuth, elevation] = pattern(monopole_antennaDesigner, freqRange(i));
  maxGain(i) = max(max(pat));
  w = waitbar(i / freqRange_size(2));
end
close(w);
figure
plot(freqRange, maxGain);
