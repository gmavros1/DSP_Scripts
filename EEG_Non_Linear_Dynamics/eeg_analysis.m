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



