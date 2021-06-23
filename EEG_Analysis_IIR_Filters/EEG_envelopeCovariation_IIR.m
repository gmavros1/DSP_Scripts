%% Check if there is any relationship between the envelope of signals captured by 19 sensors for every band.

clear all;
close all;

clear,close all
load EEG_data

% transfer function coeffs of band pass filter [delta, theta, alpha, beta, gamma]
bands = [1 4 ; 4 8 ; 8 13 ; 13 30 ; 30 45];
coeffsA = [];
coeffsB = [];
filteredSignal = [];

% bands isolation
for i = 1:5
    [coeffsA(i,:), coeffsB(i,:)]= butter(5,bands(i,:)/(Fs/2));  %%% Nnormalize frequencies - bandpass filter (order 5) - coeffs
    filteredSignal(:,:,i)=filtfilt(coeffsA(i,:),coeffsB(i,:),data')'; %%% every element of the array is a band of the signal
end

% Discrit time analytic signal - abs for envelope
for i = 1:19
    Hsignal1(i,:) = abs(hilbert(filteredSignal(i,:,1)));
    Hsignal2(i,:) = abs(hilbert(filteredSignal(i,:,2)));
    Hsignal3(i,:) = abs(hilbert(filteredSignal(i,:,3)));
    Hsignal4(i,:) = abs(hilbert(filteredSignal(i,:,4)));
    Hsignal5(i,:) = abs(hilbert(filteredSignal(i,:,5)));
end

% plot the envelope - 19th sensor - alpha band
figure(1)
t = 1:1000;
plot(t,Hsignal3(19,t),t,filteredSignal(19,t,3),'r');

% returns the matrices R(i) of correlation coefficients for signals envelopes 
R(:,:,1) = corrcoef(Hsignal1(:,:)');
R(:,:,2) = corrcoef(Hsignal2(:,:)');
R(:,:,3) = corrcoef(Hsignal3(:,:)');
R(:,:,4) = corrcoef(Hsignal4(:,:)');
R(:,:,5) = corrcoef(Hsignal5(:,:)');

bandsTitle = ["Delta" "Theta" "Alpha" "Beta" "Gamma"];

% plot
figure(2)
for i = 1:5
    subplot(2,3,i);
    imagesc(R(:,:,i));
    colormap(jet);
    colorbar;
    title(bandsTitle(i));
    axis square
end

% Some relation in alpha band..

