function [ pitch,clarity ] = normACF02( x,Fs,minFreq,maxFreq,k )

pitch = 0;
clarity = 1;

minLag = floor(Fs/minFreq);
maxLag = floor(Fs/maxFreq);

r = zeros(1,minLag);
for i = 1:minLag
    x_j = x(1:minLag-i+1);
    x_jr = x(i:minLag);
    r(i) = sum ( x_j.*x_jr ) / ( sqrt(sum(x_j.^2) * sum(x_jr.^2)));
end
r = r(maxLag:end);

[maxvalue,maxindex] = max(r);
clarity = maxvalue;
maxindex =  maxindex+maxLag;
pitch = Fs/maxindex;

if pitch < 250
   v = 0; 
end

end

