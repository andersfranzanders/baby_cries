pathToTrainingset = '../audiobase/temptestbase/';
training_set = getAllFileNamesInDirectory(pathToTrainingset);

%Plot Input Signal
 figure('Name', 'Signal','position', [200, 200, 700, 400])

for i = 1:length(training_set)
    [x,Fs,classSignal] = readInAudioAndClassification(strcat(pathToTrainingset,training_set{i}));
    
    hold on;
    t = (0:1/Fs:(length(x)-1)/Fs);
    subplot(length(training_set)*2,1,2*i-1);    
    plot(t,x);
    
    [calCs,support,realCs,xInWindows,spectogram,ceptogram] = voiceActivityDetection( x,classSignal,25,Fs );
%     [pitchByAMFD, pitchByACF,pitchByMACF,pitchByMAMFD,pitchByCepstrum,pitchByHPS,pitchByDomFreq] = pitchDetect(xInWindows,calCs,Fs,200,2000,ceptogram,spectogram);
     
    hold on;
    subplot(length(training_set)*2,1,2*i-1);    
    plot(support/Fs,realCs);
    
    hold on;
    subplot(length(training_set)*2,1,2*i-1);    
    plot(support/Fs,calCs*0.8, 'g');
    
%     hold on;
%     subplot(length(training_set)*2,1,2*i);    
%     plot(support/Fs,pitchByHPS, 'm');
%     
%     hold on;
%     subplot(length(training_set)*2,1,2*i);    
%     plot(support/Fs,pitchByACF, 'g');
end