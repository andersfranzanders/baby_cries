pathToTrainingset = '../audiobase/temptestbase/';
training_set = getAllFileNamesInDirectory(pathToTrainingset);

%Plot Input Signal
 figure('Name', 'Signal','position', [200, 200, 700, 400])

for i = 1:length(training_set)
    [x,Fs,classSignal] = readInAudioAndClassification(strcat(pathToTrainingset,training_set{i}));
    
    t = (0:1/Fs:(length(x)-1)/Fs);
    
    [calCs,support,realCs,xInWindows,spectogram,ceptogram] = voiceActivityDetection( x,classSignal,25,Fs );
    [breakpointsDens, densities, breakpointsTempo, tempos, tempoErrors] = SWTD_cascaded( calCs,0.24,0.15 );
    %[breakpointsDens, densities, breakpointsTempo, tempos, tempoErrors] = SWTD_cascaded( calCs,0.65,0.15 );
    [pitch] = testOnePitchAlgo(xInWindows,calCs,Fs,200,2000,ceptogram,spectogram);
    
    hold on;
    subplot(length(training_set),1,i);    
    stem(support/Fs,tempos, 'm');
    
    hold on;
    subplot(length(training_set),1,i);    
    stem(support/Fs,densities, 'c');
    
    hold on;
    subplot(length(training_set),1,i);    
    plot(t,x,'Color',[0.5,0.5,0.5]);
    
    new_x = convertToBlackX(x,calCs,support);
    subplot(length(training_set),1,i);    
    plot(t,new_x,'k');
    
%     hold on;
%     subplot(length(training_set),1,i);    
%     plot(support/Fs,pitch./2100, 'Color',  [1, 0.3, 1]);

end