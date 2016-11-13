function M = postProcessM(M)

for i = 2:length(M)-1
    if M(i-1) == 0 && M(i) == 0.8 && M(i+1) == 0
        M(i) = 0;
    end
    if M(i-1) == 0.8 && M(i) == 0 && M(i+1) == 0.8
        M(i) = 0;
    end
end

for i = 3:length(M)-1
    if M(i-2) == 0 && M(i-1) == 0.8 && M(i) == 0.8 && M(i+1) == 0
        M(i) = 0;
    end
    if M(i-2) == 0.8 && M(i-1) == 0.8 && M(i) == 0 && M(i+1) == 0.8
        M(i) = 0;
    end
end



end

