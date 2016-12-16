pathToMatrixes = 'vad/matrix_out/2000/box_evaluation/';

modelNames = {'CeD002','CeD003'};
testSets = {'3db','50db','7db_test'};
out = zeros(length(testSets),3);

for i=1:length(testSets)
    testSet = testSets{i}
    
    filename1 = (strcat(pathToMatrixes,'eval_',modelNames{1},'-->',testSet,'.txt'));
    M1 = importdata(filename1,' ');

    filename2 = (strcat(pathToMatrixes,'eval_',modelNames{2},'-->',testSet,'.txt'));
    M2 = importdata(filename2,' ');

    sensitivityTest = kstest2(M1(:,1), M2(:,1));
    specificityTest = kstest2(M1(:,2), M2(:,2));
    accuracyTest = kstest2(M1(:,3), M2(:,3));
    
    out(i,1) = sensitivityTest;
    out(i,2) = specificityTest;
    out(i,3) = accuracyTest;

end

out

outname = strcat('ksTest_',modelNames{1},'-vs-',modelNames{2});
dlmwrite(strcat(pathToMatrixes,outname,'.txt'),out,'delimiter',' ');
