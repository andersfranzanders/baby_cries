function [ x, c, Fs ] = timeAnalysis_masterUseCase02( pathToCrySet, pathToNoiseSignal,aimSNRinDB )

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
firstPause = zeros(1, floor(25*Fs));
x = [firstPause,x];
c = [firstPause,c];


%%% First thing
[ x_seg,c_seg ] = produceConstantSegment(crySet,Fs,50, 3, 0, 0.5, 0, 0.5);
x = [x,x_seg];
c = [c,c_seg];

%%% loooong pause
pause = zeros(1, floor( 30 *Fs));
x = [x,pause];
c = [c,pause];
%%% First second
[ x_seg,c_seg ] = produceConstantSegment(crySet,Fs,40, 4, 0, 0.75, 0, 0.5);
x = [x,x_seg];
c = [c,c_seg];

[ x_seg,c_seg ] = produceConstantSegment(crySet,Fs,10, 4, 0, 0.25, 0, 0.5);
x = [x,x_seg];
c = [c,c_seg];

[ x_seg,c_seg ] = produceConstantSegment(crySet,Fs,30, 4, 0, 0.5, 0, 0.5);
x = [x,x_seg];
c = [c,c_seg];

%%% loooong pause
pause = zeros(1, floor( 25 *Fs));
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

