pathToTrainingset = '/Users/franzanders/Documents/HTWK/Master/5. Semester/Masterarbeit_LaBP/baby_code_privateGit/vad/matrix_out/mirroredMins_tiefe3/training_arff/50+3db';
pathToTestset = '/Users/franzanders/Documents/HTWK/Master/5. Semester/Masterarbeit_LaBP/baby_code_privateGit/vad/matrix_out/mirroredMins_tiefe3/training_arff/7db_test';
outPath = '/Users/franzanders/Documents/HTWK/Master/5. Semester/Masterarbeit_LaBP/baby_code_privateGit/vad/matrix_out/mirroredMins_tiefe3/weka_reports/';


preambel = 'java -cp';
wekapath = ' /Applications/Weka/weka-3-6-13/weka.jar';
classifier = ' weka.classifiers.trees.REPTree -M 2 -V 0.001 -N 3 -S 1 -L 3 -t';
training_set_names = getAllFileNamesInDirectory(pathToTrainingset);
test_set_names = getAllFileNamesInDirectory(pathToTestset);


for i = 1:length(training_set_names);
     %message = strcat(preambel, wekapath, classifier, ' "',pathToTrainingset,'/',training_set_names{i},'"');
     message = strcat(preambel, wekapath, classifier, ' "',pathToTrainingset,'/',training_set_names{i},'"', ' -T "',pathToTestset,'/',test_set_names{i},'"');

    
    [s,cmdout] = system(message);
    cmdout
    cmodout_mod = strrep(cmdout, '%', '');
    fid = fopen(strcat(outPath,training_set_names{i},'->',test_set_names{i},'_report.txt'),'w');
    %fid = fopen(strcat(outPath,training_set_names{i},'_report.txt'),'w');
    fprintf(fid, cmodout_mod);
    fclose(fid);

end



