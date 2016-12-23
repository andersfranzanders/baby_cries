pathToTrainingset = '../audiobase/temptestbase/';
training_set = getAllFileNamesInDirectory(pathToTrainingset);

%Plot Input Signal
 figure('Name', 'Signal','position', [200, 200, 700, 400])

for i = 1:length(training_set)
    [x,Fs,classSignal] = readInAudioAndClassification(strcat(pathToTrainingset,training_set{i}));
    
    hold on;
    t = (0:1/Fs:(length(x)-1)/Fs);
    
    
    [calCs,support,realCs,xInWindows,spectogram,ceptogram] = voiceActivityDetection( x,classSignal,25,Fs );
    [ breakpoints,densitiesOfSegments] = SWTD_errorThreshold( calCs,2000 );

   
    
    hold on;
    subplot(length(training_set),1,i);    
    stem(support/Fs,densitiesOfSegments / (1.5*max(densitiesOfSegments)), 'g');
    
    hold on;
    subplot(length(training_set),1,i);    
    plot(t,x);
    
    hold on;
    subplot(length(training_set),1,i);    
    plot(support/Fs,calCs * 0.85, 'r');
    
    hold on;
    subplot(length(training_set),1,i);    
    plot(support/Fs,breakpoints, 'm');

end