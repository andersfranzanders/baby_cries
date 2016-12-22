pathToTrainingset = '../audiobase/temptestbase/';
training_set = getAllFileNamesInDirectory(pathToTrainingset);

%Plot Input Signal
 figure('Name', 'Signal','position', [200, 200, 700, 400])

for i = 1:length(training_set)
    [x,Fs,classSignal] = readInAudioAndClassification(strcat(pathToTrainingset,training_set{i}));
    
    hold on;
    t = (0:1/Fs:(length(x)-1)/Fs);
    
    
    [calCs,support,realCs,xInWindows,spectogram,ceptogram] = voiceActivityDetection( x,classSignal,25,Fs );
    [ breakpoints,densitiesOfSegments,global_errors,global_densities, global_derivs,global_regLine ] = sliding_window_segmentation( calCs, 15);
       
    
    hold on;
    subplot(length(training_set)*2,1,2*i);    
    plot(support/Fs,global_densities, 'b');
    
    hold on;
    subplot(length(training_set)*2,1,2*i);    
    plot(support/Fs,global_errors, 'g');
    
    hold on;
    subplot(length(training_set)*2,1,2*i);    
    plot(support/Fs,global_derivs, 'm');
    
       hold on;
    subplot(length(training_set)*2,1,2*i);    
    plot(support/Fs,global_regLine, 'r');
   
    
    hold on;
    subplot(length(training_set)*2,1,2*i-1);    
    stem(support/Fs,densitiesOfSegments / (2*max(densitiesOfSegments)), 'm');
    
    hold on;
    subplot(length(training_set)*2,1,2*i-1);    
    plot(t,x);
    
    hold on;
    subplot(length(training_set)*2,1,2*i-1);    
    plot(support/Fs,calCs * 0.7, 'g');
    
    hold on;
    subplot(length(training_set)*2,1,2*i-1);    
    plot(support/Fs,breakpoints, 'r');

end