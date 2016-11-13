pathToTrainingset = '../audiobase/truncated/real_noise/';
trainingSignal = 'cry_clean01_corridor_5db'

featureMatrix = zeros(1,4);

%Plot Input Signal
figure('Name', 'Signal','position', [100, 100, 700, 700])

[x,Fs,classSignal] = readInAudioAndClassification(strcat(pathToTrainingset,trainingSignal));

t = (0:1/Fs:(length(x)-1)/Fs);
hold on;
subplot(4,1,1);    
plot(t,x);

[support,M,newFeatures] = windowAndExtractFeatures( x,classSignal,25,Fs );

hold on;
subplot(4,1,1);    
plot(support/Fs,M(:,end));

hold on;
subplot(4,1,2);    
plot(support/Fs,newFeatures(8,:));

xInWindows = cutSignalIntoWindows(x,25,Fs);
specto = calSpectogram(xInWindows, 2^11);
%displaySpecto(specto,0.6);



