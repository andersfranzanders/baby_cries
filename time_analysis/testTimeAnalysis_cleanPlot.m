pathToTrainingset = '../audiobase/temptestbase/';
training_set = getAllFileNamesInDirectory(pathToTrainingset);

%Plot Input Signal
 figure('Name', 'Signal','position', [200, 200, 700, 400])

for i = 1:length(training_set)
    [x,Fs,classSignal] = readInAudioAndClassification(strcat(pathToTrainingset,training_set{i}));
    
    hold on;
    t = (0:1/Fs:(length(x)-1)/Fs);
    
    
    [calCs,support] = voiceActivityDetection( x,classSignal,25,Fs );
%    [ breakpointsDens, densities, breakpointsTempo, tempos, tempoErrors] = SWTD_cascaded( calCs,0.2,0.08 );
    [ breakpointsDens, densities, breakpointsTempo, tempos, tempoErrors] = SWTD_cascaded( calCs,0.65,0.15 );
    
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
%     plot(support/Fs,calCs * 0.85,'r');
    
%     hold on;
%     subplot(length(training_set),1,i);    
%     plot(support/Fs,breakpointsDens, 'c');

end