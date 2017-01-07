function [ noisedX ] = addNoiseToCry_noPauses( x,c,n,aimSNRinDB )

aimSNR = 10^(aimSNRinDB/10);
voicedSamples = find(c);
x = normalize(x);
x_justv = x(voicedSamples);

realSNR = mean(x_justv.^2)/mean(n.^2);
ratio = sqrt(realSNR/aimSNR);
n = n.*ratio;

newSNR = mean(x_justv.^2)/mean(n.^2);
snrDB = 10*log10(newSNR);


noisedX = x+n;
noisedX = normalize(noisedX);


end

