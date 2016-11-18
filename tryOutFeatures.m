pathToTrainingset = '../audiobase/truncated/real_noise/5db/';
trainingSignal = 'cry_clean06_hospital_5db'

featureMatrix = zeros(1,4);

%Plot Input Signal
figure('Name', 'Signal','position', [100, 100, 700, 700])

[x,Fs,classSignal] = readInAudioAndClassification(strcat(pathToTrainingset,trainingSignal));

t = (0:1/Fs:(length(x)-1)/Fs);
hold on;
subplot(4,1,1);    
plot(t,x);

[support,M] = windowAndExtractFeatures( x,classSignal,25,Fs );

hold on;
subplot(4,1,1);    
plot(support/Fs,M(:,end));

%xInWindows = cutSignalIntoWindows(x,25,Fs);
%specto = calSpectogram(xInWindows, 2^11);
%displaySpecto(specto,0.6);



