pathToTrainingset = '../audiobase/temptestbase/';
training_set = getAllFileNamesInDirectory(pathToTrainingset);

%Plot Input Signal
 figure('Name', 'Signal','position', [200, 200, 700, 400])

for i = 1:length(training_set)
    [x,Fs,pitchGT] = readInAudioAndPitchdata(strcat(pathToTrainingset,training_set{i}));
   
    hold on;
    t = (0:1/Fs:(length(x)-1)/Fs);
    
    [ support,xInWindows,specto,ceptogram] = windowAndTransform( x,25,Fs );
    [pitchMatrix] = pitchDetect(xInWindows,pitchGT,Fs,200,2000,ceptogram,spectogram);
    
    [rows,cols] = size(pitchMatrix);
    
    hold on;
    subplot(rows+2,1,1);    
    plot(t,x,'Color','k');
    
    hold on;
    subplot(rows+2,1,2);
    plot(support/Fs,pitchGT, 'm');
    
    
    for j =1:rows
        hold on;
        subplot(rows+2,1,j+2);
        plot(support/Fs,pitchMatrix(j,:), 'b');
    end    
    
    errors = calPitchErrors(pitchGT,pitchMatrix)
    octaveErrors = calOctaveErrors(pitchMatrix)
    
end