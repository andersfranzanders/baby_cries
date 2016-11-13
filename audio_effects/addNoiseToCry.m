function [ noisedX ] = addNoiseToCry( x,n,aimSNRinDB )

aimSNR = 10^(aimSNRinDB/10);

x = normalize(x);

realSNR = mean(x.^2)/mean(n.^2);
ratio = sqrt(realSNR/aimSNR);
n = n.*ratio;

newSNR = mean(x.^2)/mean(n.^2);
snrDB = 10*log10(newSNR);




noisedX = x+n;
noisedX = normalize(noisedX);


end

