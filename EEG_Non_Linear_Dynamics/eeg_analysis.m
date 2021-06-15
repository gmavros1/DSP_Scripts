%% Load Signal - band isolation
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
% plot


