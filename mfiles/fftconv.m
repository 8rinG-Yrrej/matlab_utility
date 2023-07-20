% function v = fftconv(x,y,kind)
% Compute 1D convolution with fft. kind = 'same'|'valid'|'full'.
% For matrix inputs, compute along the 1st dimension.
% The default is 'full'.
% For vectors, this is equivalent to cconv with patched-up options.
function v = fftconv(x,y,kind)
% arguments
%     x
%     y
%     kind (1,1) string = 'full'
% end

if isvector(x) && isvector(y)
  l = length(x);
  m = length(y);
else
  l = size(x,1);
  m = size(y,1);
end

v = ifft(fft(x,l+m-1).*fft(y,l+m-1));

if nargin == 2 || strcmp(kind,'full')
  return
elseif strcmp(kind,'same')
  if isvector(v)
    v = v(1+floor(m/2):floor(m/2)+l);
  else % assuming matrix. Will be error if not.
    v = reshape(v(1+floor(m/2):floor(m/2)+l,:),size(x));
  end
elseif strcmp(kind,'valid')
  if isvector(v)
    v = v(m:end-m+1);
  else % assuming matrix. Will be error if not.
    s = size(x);
    s(1)=l-m+1;
    v = reshape(v(m:end-m+1,:),s);
  end
end

end
