pathToTrainingset = '../audiobase/temptestbase/';
training_set = getAllFileNamesInDirectory(pathToTrainingset);
training_set
%Plot Input Signal
 
global_errors = [];
global_octave_errors = [];
for i = 1:length(training_set)
    training_set{i}
    figure('Name', training_set{i},'position', [200, 200, 700, 400])
    
    [ x,Fs,classSignal,pitchGT ] = readInAudioAndPitchdata(strcat(pathToTrainingset,training_set{i}));
    
    hold on;
    t = (0:1/Fs:(length(x)-1)/Fs);
    
    [ support,xInWindows,specto,ceptogram] = windowAndTransform( x,25,Fs );
    Cs = calculateClasses(xInWindows, classSignal);
    [pitchMatrix] = pitchDetect(xInWindows,Cs,Fs,200,2000,ceptogram,specto);
    
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
    
    octaveErrors = calOctaveErrors(pitchMatrix)
    global_octave_errors = [global_octave_errors;octaveErrors];
    
    errors = calPitchErrors(pitchGT,pitchMatrix)
    global_errors = [global_errors;errors];
    
end

mean_errors = mean(global_errors);
mean_octave_errors = mean(global_octave_errors);

[v,winnerIndex_errors] = min(mean_errors);
[v,winnerIndex_octaves] = min(mean_octave_errors);

winnerIndex_errors
winnerIndex_octaves
