pathToTrainingset = '../audiobase/temptestbase/';
outPath = '../audiobase/testsignals/';


training_set = getAllFileNamesInDirectory(pathToTrainingset);

%Plot Input Signal
 figure('Name', 'Signal','position', [200, 200, 700, 400])

for i = 1:length(training_set)
    [x,Fs,classSignal] = readInAudioAndClassification(strcat(pathToTrainingset,training_set{i}));
    
    hold on;
    t = (0:1/Fs:(length(x)-1)/Fs);
    
    
    [calCs,support,realCs,xInWindows,spectogram,ceptogram] = voiceActivityDetection( x,classSignal,25,Fs );
    [pitchMatrix] = pitchDetect(xInWindows,calCs,Fs,200,2000,ceptogram,spectogram);
    
    gt = calGroundTruth(pitchMatrix,3);

    hold on;
    subplot(length(training_set)*2,1,2*i-1);    
    plot(t,x,'Color',[0.4, 0.4, 0.4]);
    
    new_x = convertToBlackX(x,calCs,support);
    subplot(length(training_set)*2,1,2*i-1); 
    plot(t,new_x,'k');
    
    hold on;
    subplot(length(training_set)*2,1,2*i);    
    plot(support/Fs,gt, 'b');
    
    filename = strcat(outPath,training_set{i},'_pitchGroundTrouth');
    audiowrite(strcat(filename,'.wav'),x,Fs,'BitsPerSample',16);
    dlmwrite(strcat(filename,'.txt'),gt','delimiter',' ');
    
end