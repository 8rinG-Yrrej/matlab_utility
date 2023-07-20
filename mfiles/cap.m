% function y = cap(x,a,b)
% y = max(a,min(b,x));
% Cap with real and imaginary parts of a separately. Like taxi-cab.
function y = cap(x,arg2,arg3)

if nargin == 3
  a=arg2; b=arg3;
elseif nargin == 2
  a=arg2(1); b=arg2(2);
end


rx=real(x); ra=real(a); rb=real(b);
ix=imag(x); ia=imag(a); ib=imag(b);

y = max(ra,min(rb,rx));

if ~isempty(find(ix,1))
  iy = max(ia,min(ib,ix));
  y = complex(y,iy);
end

end
