pathToTrainingset = '../audiobase/truncated/real_noise/50+5db/';
training_set = getAllFileNamesInDirectory(pathToTrainingset);
noiseLevel = '50+5db';

featureMatrix = zeros(1,11);

%Plot Input Signal
figure('Name', 'Signal','position', [100, 100, 700, 700])

for i = 1:length(training_set)
    training_set{i}
    [x,Fs,classSignal] = readInAudioAndClassification(strcat(pathToTrainingset,training_set{i}));

    
    [support,M] = windowAndExtractFeatures( x,classSignal,25,Fs );
    

    featureMatrix = cat(1,featureMatrix,M);
end

featureMatrix = doubleNegativeClasses(featureMatrix);

dlmwrite(strcat('matrix_out/featureMatrix_',noiseLevel,'_all.arff'),featureMatrix);
dlmwrite(strcat('matrix_out/featureMatrix_',noiseLevel,'_TD.arff'),featureMatrix(:,[1,2,11]));
dlmwrite(strcat('matrix_out/featureMatrix_',noiseLevel,'_FD.arff'),featureMatrix(:,[3,4,5,11]));
dlmwrite(strcat('matrix_out/featureMatrix_',noiseLevel,'_CeD.arff'),featureMatrix(:,[6,7,8,11]));
dlmwrite(strcat('matrix_out/featureMatrix_',noiseLevel,'_CoD.arff'),featureMatrix(:,[9,10,11]));
dlmwrite(strcat('matrix_out/featureMatrix_',noiseLevel,'_TD+FD.arff'),featureMatrix(:,[1,2,3,4,5,11]));
dlmwrite(strcat('matrix_out/featureMatrix_',noiseLevel,'_TD+CeD.arff'),featureMatrix(:,[1,2,6,7,8,11]));
dlmwrite(strcat('matrix_out/featureMatrix_',noiseLevel,'_TD+CoD.arff'),featureMatrix(:,[1,2,9,10,11]));
dlmwrite(strcat('matrix_out/featureMatrix_',noiseLevel,'_FD+CeD.arff'),featureMatrix(:,[3,4,5,6,7,8,11]));
dlmwrite(strcat('matrix_out/featureMatrix_',noiseLevel,'_FD+CoD.arff'),featureMatrix(:,[3,4,5,9,10,11]));