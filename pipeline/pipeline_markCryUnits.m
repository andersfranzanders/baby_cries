function [ cryUnits ] = pipeline_markCryUnits( support, Cs, Fs )

cryUnits = [];

dCs = diff(Cs);
dCs = [0, dCs];

startpoint = 0;
for i = 1:length(dCs)
   if dCs(i) == 1
        startpoint = support(i);
   end
   if dCs(i) == -1
       endpoint = support(i);
       cryUnits = [cryUnits;startpoint, endpoint ];
       startpoint = 0;
   end
       
end

if startpoint ~= 0 
   endpoint = support(i);
   cryUnits = [cryUnits;startpoint, endpoint ];
end

end

