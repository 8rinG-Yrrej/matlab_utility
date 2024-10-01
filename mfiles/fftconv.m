% function v = fftconv(x1,x2,...,xn,kind='full')
% Compute 1D convolution with fft. kind = 'same'|'valid'|'full'.
% For matrix inputs, compute along the 1st dimension.
% The default is 'full'.
% For vectors, this is equivalent to cconv with patched-up options.
% When there are n>2 terms, compute the convolution between each pair.
% These can be much slower that fftconv pairwise or folding fftconv.
function v = fftconv(x,y,varargin)
% arguments
%     x
%     y
%     kind (1,1) string = 'full'
% end

if nargin > 2 
  if ischar(varargin{end}) || isstring(varargin{end})
    kind = varargin{end};
    varargin(end)=[];
  else
    kind='full';
  end
  
  lv=length(varargin);
else
  lv=0;
end

if isvector(x) && isvector(y)
  l = length(x);
  m = length(y);
  if 0~=lv
    m=m+sum(cellfun(@length,varargin))-lv;
  end
else
  l = size(x,1);
  m = size(y,1);
  if 0~=lv
    m=m+sum(cellfun(@(x)size(x,1),varargin))-lv;
  end
end

lt=l+m-1;
if 0==lv
  v = ifft(fft(x,lt).*fft(y,lt));
else
  v = ifft(fft(x,lt).*fft(y,lt).* cumprod(cell2mat(cellfun(@(a)fft(a,lt),varargin,'uniformoutput',false)),2));
end

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
