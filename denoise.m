% Load sound signal  
[y, Fs] = audioread("songClear.mp3");
Ts = 1/Fs;
y = y(numel(y)/40:numel(y)/40 + 500000); % Choose a part 
t = 1:numel(y);
time = Ts*t;
plot(time, y);
title('Clear Signal');
xlabel("Seconds")
sound(y,Fs);
%__________________________________________________________________________

