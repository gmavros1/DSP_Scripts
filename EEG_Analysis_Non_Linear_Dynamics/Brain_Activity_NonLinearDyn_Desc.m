%% A NonLinear Dynamics description of the brain activity as a function of brain-rhythm

%  Load Signal - band isolation - plot spot diffs
clear all;
load EEG_data.mat

% transfer function coeffs of band pass filter [delta, theta, alpha, beta, gamma]
bands = [1 4 ; 4 8 ; 8 13 ; 13 30 ; 30 45];
coeffsA = [];
coeffsB = [];
filteredSignal = [];

for i = 1:5
    [coeffsA(i,:), coeffsB(i,:)]= butter(5,bands(i,:)/(Fs/2));  %%% Nnormalize frequencies - bandpass filter (order 5 of filter) - coeffs
    filteredSignal(:,:,i)=filtfilt(coeffsA(i,:),coeffsB(i,:),data')'; %%% every element of the array is a band of the signal
end

% filteredSignal(sensor index, signal values, band)
% plot first 10 secs

sensor = 5; % Say the 5th sensor 

figure(1)
subplot(2,3,1);plot(data(sensor,1:10*Fs));title("EEG");

bandsTitle = ["Delta" "Theta" "Alpha" "Beta" "Gamma"];
for i = 1:5
    subplot(2,3,i+1);plot(filteredSignal(sensor,1:10*Fs, i));title(bandsTitle(i));
end

% represent each EEG band as a dynamical trajectory 

[XX, eLAG, eDIM] = phaseSpaceReconstruction(data(sensor,1:10*Fs));
[XX1, eLAG1, eDIM1] = phaseSpaceReconstruction(filteredSignal(sensor,1:10*Fs, 1));
[XX2, eLAG2, eDIM2] = phaseSpaceReconstruction(filteredSignal(sensor,1:10*Fs, 2));
[XX3, eLAG3, eDIM3] = phaseSpaceReconstruction(filteredSignal(sensor,1:10*Fs, 3));
[XX4, eLAG4, eDIM4] = phaseSpaceReconstruction(filteredSignal(sensor,1:10*Fs, 4));
[XX5, eLAG5, eDIM5] = phaseSpaceReconstruction(filteredSignal(sensor,1:10*Fs, 5));

% Predictability of the EEG-trace for every band - approximateEntropy
% smaller approximateEntropy --> more predictable the signal

aE1 = approximateEntropy((filteredSignal(sensor,1:10*Fs, 1)),eLAG1,eDIM1);
aE2 = approximateEntropy((filteredSignal(sensor,1:10*Fs, 2)),eLAG2,eDIM2);
aE3 = approximateEntropy((filteredSignal(sensor,1:10*Fs, 3)),eLAG3,eDIM3);
aE4 = approximateEntropy((filteredSignal(sensor,1:10*Fs, 4)),eLAG4,eDIM4);
aE5 = approximateEntropy((filteredSignal(sensor,1:10*Fs, 5)),eLAG5,eDIM5);

% level of chaotic complexity in the EEG-trace for every band - correlationDimension
% smaller correlationDimension --> smaller level of chaotic complexity

cDim1 = correlationDimension((filteredSignal(sensor,1:10*Fs, 1)),eLAG1,eDIM1);
cDim2 = correlationDimension((filteredSignal(sensor,1:10*Fs, 2)),eLAG2,eDIM2);
cDim3 = correlationDimension((filteredSignal(sensor,1:10*Fs, 3)),eLAG3,eDIM3);
cDim4 = correlationDimension((filteredSignal(sensor,1:10*Fs, 4)),eLAG4,eDIM4);
cDim5 = correlationDimension((filteredSignal(sensor,1:10*Fs, 5)),eLAG5,eDIM5);

% Plot

figure(2);
subplot(2,3,1);plot3(XX(1:1000,1),XX(1:1000,2),XX(1:1000,3));grid
title("EEG");

subplot(2,3,2);plot3(XX1(1:1000,1),XX1(1:1000,2),XX1(1:1000,3));grid
title("Delta"); 
text(0,4,0,"approximateEntropy");text(0,0,0,num2str(aE1));
text(0,-4,0,"correlationDimension");text(0,-8,0,num2str(cDim1));

subplot(2,3,3);plot3(XX2(1:1000,1),XX2(1:1000,2),XX2(1:1000,3));grid
title("Theta");
text(-12,5,0,"approximateEntropy");text(-12,0,0,num2str(aE2));
text(0,-5,0,"correlationDimension");text(0,-10,0,num2str(cDim2));


subplot(2,3,4);plot3(XX3(1:1000,1),XX3(1:1000,2),XX3(1:1000,3));grid
title("Alpha");
text(0,5,+15,"approximateEntropy");text(-3,0,+15,num2str(aE3));
text(0,-5,-20,"correlationDimension");text(0,-10,-23,num2str(cDim3));

subplot(2,3,5);plot3(XX4(1:1000,1),XX4(1:1000,2),XX4(1:1000,3));grid
title("Beta");
text(0,5,+15,"approximateEntropy");text(-3,0,+15,num2str(aE4));
text(0,-5,-20,"correlationDimension");text(0,-10,-23,num2str(cDim4));

subplot(2,3,6);plot3(XX5(1:1000,1),XX5(1:1000,2),XX5(1:1000,3));grid
title("Gamma");
text(0,4,-5,"approximateEntropy");text(0,0,-5,num2str(aE5));
text(0,-4,0,"correlationDimension");text(0,-8,0,num2str(cDim5));

