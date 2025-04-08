% function v = fftconvn(x,y,kind)
% Compute nD convolution with fft. kind = 'same'|'valid'|'full'.
% For matrix inputs, compute along the 1st dimension.
% The default is 'full'.
% For vectors, this is equivalent to cconv with patched-up options.
function v = fftconvn(x,y,kind)
% arguments
%     x
%     y
%     kind (1,1) string = 'full'
% end

l = size(x);
m = size(y);

v = ifftn(fftn(x,l+m-1).*fftn(y,l+m-1));

if nargin == 2 || strcmp(kind,'full')
  return
elseif strcmp(kind,'same')
  nn = length(l);
  cc = cell(1,nn);
  for ii = 1:nn
    cc{ii} = 1+floor(m(ii)/2):floor(m(ii)/2)+l(ii);
  end
  v = v(cc{:});
elseif strcmp(kind,'valid')
  nn = length(l);
  cc = cell(1,nn);
  for ii = 1:nn
    cc{ii} = m(ii):l(ii);
  end
  v = v(cc{:});
  if isvector(v)
    v = v(m:end-m+1);
  else % assuming matrix. Will be error if not.
    s = size(x);
    s(1)=l-m+1;
    v = reshape(v(m:end-m+1,:),s);
  end
end

end
