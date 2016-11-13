function [ support,Ents ] = thresholdSpectoFeatures(support,domfreqs,Es, DFs)

Ents = zeros(1,length(domfreqs));
for i = 1:length(domfreqs)
   value = domfreqs(i);
   if (value < -0.4 && Es(i) >0) || (DFs(i) > 0.11 && Es(i) >0)
       Ents(i) = 0.75;
   else
       Ents(i) = 0;
   end
end


end

