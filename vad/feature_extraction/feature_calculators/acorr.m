function [ a ] = acorr( x, lag )

a = zeros(1,lag);

for k = 1:length(a)
    a(k) = sum(x(k:end).*x(k+1-k:end-k+1));
    %a(k) = a(k)/(sqrt((sum(x(1:end+1-k).^2)))*sqrt((sum(x(k:end).^2))));
end
a = a/a(1);



end

