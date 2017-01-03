pathToTrainingset = '../audiobase/temptestbase/';
training_set = getAllFileNamesInDirectory(pathToTrainingset);

%Plot Input Signal
 figure('Name', 'Signal','position', [200, 200, 700, 400])

for i = 1:length(training_set)
    
    [x,Fs,classSignal] = readInAudioAndClassification(strcat(pathToTrainingset,training_set{i}));
    
    hold on;
    t = (0:1/Fs:(length(x)-1)/Fs);
    
    [ support,xInWindows,specto,ceptogram] = windowAndTransform( x,25,Fs );
    Cs = calculateClasses(xInWindows, classSignal);

    
    %thresholds = 0.75:0.01:1
    %thresholds = [0.75,0.95]
    thresholds = 3:8;
    [ pitchMatrix ] = applyThresholdsToPAD( xInWindows,Cs,thresholds,Fs,200,2000,specto);
     

    hold on;
    subplot(length(training_set)*2,1,2*i-1);    
    plot(t,x,'Color',[0.4, 0.4, 0.4]);
    
    new_x = convertToBlackX(x,Cs,support);
    subplot(length(training_set)*2,1,2*i-1); 
    plot(t,new_x,'k');
    
    pitchErrors = calOctaveErrors(pitchMatrix)
    [minValue,minIndex] = min(pitchErrors);
    winnerThreshold = thresholds(minIndex)
    
    hold on;
    subplot(length(training_set)*2,1,2*i); 
    plot(support/Fs,pitchMatrix(minIndex,:),'m');

    
end