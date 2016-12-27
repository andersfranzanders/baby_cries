pathToTrainingset = '../audiobase/temptestbase/';
training_set = getAllFileNamesInDirectory(pathToTrainingset);

%Plot Input Signal
 figure('Name', 'Signal','position', [200, 200, 700, 400])

for i = 1:length(training_set)
    [x,Fs,classSignal] = readInAudioAndClassification(strcat(pathToTrainingset,training_set{i}));
    
    hold on;
    t = (0:1/Fs:(length(x)-1)/Fs);
    
    
    [calCs,support] = voiceActivityDetection( x,classSignal,25,Fs );
   % [  breakpoints,featuresOfSegments,global_errors,global_features, global_derivatives,global_regLines ] = SWTD_generic_RSEThreshold(calCs,'densities',0.35);
    [ breakpointsDens, densities, breakpointsTempo, tempos, tempoErrors] = SWTD_cascaded( calCs, 0.2, 0.1 );
    
    hold on;
    subplot(length(training_set)*2,1,2*i);    
    plot(support/Fs,tempoErrors, 'g');

     hold on;
    subplot(length(training_set)*2,1,2*i-1);    
    stem(support/Fs,densities, 'c');
    
     hold on;
    subplot(length(training_set)*2,1,2*i-1);    
    stem(support/Fs,tempos, 'm');
    
    hold on;
    subplot(length(training_set)*2,1,2*i-1);    
    plot(t,x, 'k');
    
    hold on;
    subplot(length(training_set)*2,1,2*i-1);    
    plot(support/Fs,calCs * 0.7, 'r');
    
%     hold on;
%     subplot(length(training_set)*2,1,2*i-1);    
%     stairs(support/Fs,breakpointsDens, 'c');
%     
%      hold on;
%     subplot(length(training_set)*2,1,2*i-1);    
%     stairs(support/Fs,breakpointsTempo, 'm');

end