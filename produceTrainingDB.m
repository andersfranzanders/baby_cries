pathToTrainingset = '../audiobase/truncated/clean/';
training_set = getAllFileNamesInDirectory(pathToTrainingset);
%training_set = {'cry_clean01','cry_clean02','cry_clean03','cry_clean04','cry_clean05','cry_clean06'};

% pathToTrainingset = '../audiobase/truncated/real_noise/';
% training_set = {
% 'cry_clean01_corridor_5db'
% 'cry_clean01_corridor_15db'
% 'cry_clean02_hospital_5db'
% 'cry_clean02_hospital_15db'};

featureMatrix = zeros(1,11);

%Plot Input Signal
figure('Name', 'Signal','position', [100, 100, 700, 700])

for i = 1:length(training_set)
    training_set{i}
    [x,Fs,classSignal] = readInAudioAndClassification(strcat(pathToTrainingset,training_set{i}));

   
    %sound(x,Fs);
    %t = (0:1/Fs:(length(x)-1)/Fs);
    %subplot(length(training_set),1,i);    
    %plot(t,x);
    
    [support,M] = windowAndExtractFeatures( x,classSignal,25,Fs );
    
    %hold on;
    %subplot(length(training_set),1,i);    
    %plot(support/Fs,M(:,end));

    featureMatrix = cat(1,featureMatrix,M);
end

featureMatrix = doubleNegativeClasses(featureMatrix);

%dlmwrite('matrix_out/featureMatrix_clean03.arff',featureMatrix);



