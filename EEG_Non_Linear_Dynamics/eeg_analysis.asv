%% Load Signal - band isolation - plot spot diffs
clear all;
load EEG_data.mat

% transfer function coeffs of band pass filter [delta, theta, alpha, beta, gamma]
bands = [1 4 ; 4 8 ; 8 13 ; 13 30 ; 30 45];
coeffsA = [];
coeffsB = [];
filteredSignal = [];

for i = 1:5
    [coeffsA(i,:), coeffsB(i,:)]= butter(5,bands(i,:)/(Fs/2));  %%% Nnormalize frequencies - bandpass filter (order 5) - coeffs
    filteredSignal(:,:,i)=filtfilt(coeffsA(i,:),coeffsB(i,:),data')'; %%% every element of the array is a band of the signal
end

% filteredSignal(sensor index, signal values, band)
% plot first 10 secs

sensor = 5; % say the 5th sensor 

figure(1)
subplot(2,3,1);plot(data(sensor,1:10*Fs));title("EEG");

bandsTitle = ["Delta" "Theta" "Alpha" "Beta" "Gamma"];
for i = 1:5
    subplot(2,3,i+1);plot(filteredSignal(sensor,1:10*Fs, i));title(bandsTitle(i));
end

%% represent each EEG band as a dynamical trajectory 

[XX, eLAG, eDIM] = phaseSpaceReconstruction(data(sensor,1:10*Fs));
[XX1, eLAG1, eDIM1] = phaseSpaceReconstruction(filteredSignal(sensor,1:10*Fs, 1));
[XX2, eLAG2, eDIM2] = phaseSpaceReconstruction(filteredSignal(sensor,1:10*Fs, 2));
[XX3, eLAG3, eDIM3] = phaseSpaceReconstruction(filteredSignal(sensor,1:10*Fs, 3));
[XX4, eLAG4, eDIM4] = phaseSpaceReconstruction(filteredSignal(sensor,1:10*Fs, 4));
[XX5, eLAG5, eDIM5] = phaseSpaceReconstruction(filteredSignal(sensor,1:10*Fs, 5));

% Predictability of the EEG-trace - approximateEntropy

aE1 = approximateEntropy((filteredSignal(sensor,1:10*Fs, 1)),eLAG,eDIM);
aE2 = approximateEntropy((filteredSignal(sensor,1:10*Fs, 2)),eLAG,eDIM);
aE3 = approximateEntropy((filteredSignal(sensor,1:10*Fs, 3)),eLAG,eDIM);
aE4 = approximateEntropy((filteredSignal(sensor,1:10*Fs, 4)),eLAG,eDIM);
aE5 = approximateEntropy((filteredSignal(sensor,1:10*Fs, 5)),eLAG,eDIM);

% level of chaotic complexity in the EEG-trace - correlationDimension

cDim1 = correlationDimension((filteredSignal(sensor,1:10*Fs, 1)),eLAG,eDIM);
cDim2 = correlationDimension((filteredSignal(sensor,1:10*Fs, 2)),eLAG,eDIM);
cDim3 = correlationDimension((filteredSignal(sensor,1:10*Fs, 3)),eLAG,eDIM);
cDim4 = correlationDimension((filteredSignal(sensor,1:10*Fs, 4)),eLAG,eDIM);
cDim5 = correlationDimension((filteredSignal(sensor,1:10*Fs, 5)),eLAG,eDIM);



figure(2);
subplot(2,3,1);plot3(XX(1:1000,1),XX(1:1000,2),XX(1:1000,3));grid
title("EEG");
subplot(2,3,2);plot3(XX1(1:1000,1),XX1(1:1000,2),XX1(1:1000,3));grid
title("Delta");
subplot(2,3,3);plot3(XX2(1:1000,1),XX2(1:1000,2),XX2(1:1000,3));grid
title("Theta");
subplot(2,3,4);plot3(XX3(1:1000,1),XX3(1:1000,2),XX3(1:1000,3));grid
title("Alpha");
subplot(2,3,5);plot3(XX4(1:1000,1),XX4(1:1000,2),XX4(1:1000,3));grid
title("Beta");
subplot(2,3,6);plot3(XX5(1:1000,1),XX5(1:1000,2),XX5(1:1000,3));grid
title("Gamma");


