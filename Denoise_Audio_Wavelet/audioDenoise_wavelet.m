% Load sound signal  

[y, Fs] = audioread("songClear.mp3");
Ts = 1/Fs;
y = y(numel(y)/40:numel(y)/40 + 125000); % Choose a part 
t = 1:numel(y);
time = Ts*t;
figure(1);

plot(time, y);
title('Clear Signal');
xlabel("Seconds")
% sound(y,Fs);
%__________________________________________________________________________

% Add some white Gaussian noise

ynoise = awgn(y,5,'measured');

figure(2);
plot(time,ynoise, time, y)
legend("clear Signal", "Signal with noise");
% sound(ynoise, Fs)

%__________________________________________________________________________

% Denoise

yDenoised = wdenoise(ynoise,10,'Wavelet','db1');

% Results

figure(3);
subplot(2,2,1); plot(time, y); title('Clear Signal'); xlabel("Seconds")
subplot(2,2,2); plot(time, ynoise); title('Signal with noise'); xlabel("Seconds")
subplot(2,2,3); plot(time, y); title('Denoised Signal'); xlabel("Seconds")
subplot(2,2,4); plot(time, y, time, yDenoised); title('Denoised Signal - Clear signal'); xlabel("Seconds");
legend("Clear","Denoised");

% sound(yDenoised,Fs)



