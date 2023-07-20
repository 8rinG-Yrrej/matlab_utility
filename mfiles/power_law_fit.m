% function [r,a,f,s] = power_law_fit(x,y)
% Power law fit to x-y data.
% r is the power law. a is the prefactor.
% a is the residue
% f is the power law function, such that f(x)~y.
% s is the same s as returned by polyfit.
function [r,a,f,s] = power_law_fit(x,y)

if isvector(x) && isvector(y)
  if size(x) ~= size(y)
    y = reshape(y,size(x));
  end
end

[p,s,mu] = polyfit(log(x), log(y), 1);

r = p(1)/mu(2);
a = exp(p(2)-r*mu(1));
f = @(x) exp(polyval(p,(log(x)-mu(1))/mu(2)));
end
