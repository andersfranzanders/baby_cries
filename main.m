[x,Fs] = readInAudio('training_set/cry_train01.wav');
t = (0:1/Fs:(length(x)-1)/Fs);sound(x,Fs);
x = normalize(x);
%Plot Input Signal
figure('Name', 'Signal','position', [100, 100, 700, 700])
subplot(4,1,1);    
plot(t,x);

%Compress Signal and Plot it
x = compressDynamicly(x,0.2);
subplot(4,1,2);    
plot(t,x);

%Cut Signal into window-Chunks.

[support, EDetect, VDetect] = voiceActivityDetection(x,Fs,25);

hold on;
subplot(4,1,2)
plot(support/Fs,EDetect);

subplot(4,1,2)
plot(support/Fs,VDetect,'m');

xInWindows = cutSignalIntoWindows(x,25,Fs);
specto = calSpectogram(xInWindows, 2^11);
displaySpecto(specto,0.6);

%ceptogram = calCeptogram(specto);
%[support,Cs] = thresholdCeptogram(ceptogram,support);

%mfccgram = calMFCCgram( specto, Es, 26,13,100,10000, Fs);
%[support, mfccs] = thresholdMFFCgram(mfccgram, support);

