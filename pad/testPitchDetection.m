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
    %[pitchByMPM,clarityByMPM,pitchByNormACF,clarityByNormACF] = pitchDetect(xInWindows,calCs,Fs,200,2000,ceptogram,spectogram);
    [ pitches] = testOnePitchAlgo( xInWindows,Cs,Fs,200,2000,ceptogram,specto);

    hold on;
    subplot(length(training_set)*2,1,2*i-1);    
    plot(t,x,'Color',[0.4, 0.4, 0.4]);
    
    new_x = convertToBlackX(x,Cs,support);
    hold on;
    subplot(length(training_set)*2,1,2*i-1); 
    plot(t,new_x,'k');
    
    hold on;
    subplot(length(training_set)*2,1,2*i);    
    plot(support/Fs,pitches, 'm');

    
end