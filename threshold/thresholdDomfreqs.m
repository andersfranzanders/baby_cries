function [ support,DFs ] = thresholdDomfreqs(support,domfreqs,Es)

DFs = zeros(1,length(domfreqs));
for i = 1:length(domfreqs)
   value = domfreqs(i);
   if value > 0.11 && Es(i) >0
       DFs(i) = 0.75;
   else
       DFs(i) = 0;
   end
end


end

