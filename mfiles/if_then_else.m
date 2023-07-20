% function [v] = if_then_else(a,b,c)
% Assign v according to logical(s) in a. If true then b, else c.
% v same shape as a. b,c either scalar or same shape as v,a.
% Common usage: avoid offending NaNs.
function [v] = if_then_else(a,b,c)
if length(a) > 1
  v = zeros(size(a),'like',c);
  v(:) = c;
  if isscalar(b)
    v(a) = b;
  else
    v(a) = b(a);
  end
else
  if a
    v = b;
  else
    v = c;
  end
end
end
