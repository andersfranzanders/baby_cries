function [ x, c, Fs ] = timeAnalysis_densUseCase( pathToCrySet, pathToNoiseSignal,aimSNRinDB )

%read in all the cry segments into a set.
cry_set_names = getAllFileNamesInDirectory(pathToCrySet);
Fs = 0;
crySet = [];
for i = 1:length(cry_set_names)
    [audio,samplingrate] = readInAudio(strcat(pathToCrySet,cry_set_names{i}));
    Fs = samplingrate;
    audio = normalize(audio');
    crySet = [{audio}; crySet];
end


x = [];
c = [];

%begin cry with random pause
firstPause = zeros(1, floor(0.5*Fs));
x = [firstPause,x];
c = [firstPause,c];

%%% First thing
[ x_seg,c_seg ] = produceConstantSegment_words(crySet,Fs,'l', 'xs', 'zero', 'm', 'zero', 'm');
x = [x,x_seg];
c = [c,c_seg];

%%% loooong pause
pause = zeros(1, floor( 60 *Fs));
x = [x,pause];
c = [c,pause];


%%% First thing
[ x_seg,c_seg ] = produceConstantSegment_words(crySet,Fs,'xxl', 'xxl', 'zero', 'l', 'zero', 'm');
x = [x,x_seg];
c = [c,c_seg];

%%% loooong pause
pause = zeros(1, floor( 60 *Fs));
x = [x,pause];
c = [c,pause];

%%% First second
[ x_seg,c_seg ] = produceConstantSegment_words(crySet,Fs,'xxxl', 'm', 'xl', 's', 'zero', 'm');
x = [x,x_seg];
c = [c,c_seg];

%%% loooong pause
pause = zeros(1, floor( 10 *Fs));
x = [x,pause];
c = [c,pause];

%read in noise signal and concatinated it to match the cry signals size
noise = readInAudio(pathToNoiseSignal);
noise = noise';
concatNoiseSignal = [];
while length(concatNoiseSignal) < length(x)
    concatNoiseSignal = [noise, concatNoiseSignal];
end

concatNoiseSignal = concatNoiseSignal(1:length(x));

x = addNoiseToCry_noPauses(x, c, concatNoiseSignal, aimSNRinDB);

end

