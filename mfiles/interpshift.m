function [lb,rb,sv] = interpshift(v,n)
%INTERPSHIFT makes linearly interpolated shift of vector v by n, n may be noninteger.
% [sv] = interpshift(v,n)
% Example: interpshift([1 2 3],0.1) == [0 1.9 2.9]
%  This is consistent with circshift(f,a), which make f(x) to f(x-a). First
%  entry of the output is zero due to unavailable data.
% ARCANE usage:
% [lb,rb,sv] = interpshift(v,n)
% Returns shifted vector sv, and corresponding left (lb) & right (rb) index into v.
% If abs(n)>length(v), returns [0,0,[]].
% Also takes some higher dimensional arrys. Operate on the 1st dimension only.


vq=isvector(v);
nd=ndims(v);
if vq
  lv = length(v);
else
  lv = size(v,1);
end

if abs(n) > lv
  lb = 0; rb = 0;
  sv = [];
else
  fn = floor(n); cn = ceil(n);

  lb = max(1,1+cn);
  rb = min(lv+fn,lv);
  rgm = rb-lb;
  % assert(rgm == lv-ceil(abs(n))-1);
  llsb = max(1,1-cn);
  % disp([lb rb rgm]);
  if vq
    if cn-n == 0
      sv = v(llsb:llsb+rgm);
    else
      sv = (1-cn+n)*v(llsb:llsb+rgm) ... %lesser
        + (cn-n)*v(llsb+1:llsb+1+rgm); %greater
    end
  
  % following is a bunch of specialized cases for array dimensions 2..4 to make things faster
  % ``think java''
  elseif ismatrix(v)
    if cn-n == 0
      sv = v(llsb:llsb+rgm,:);
    else
      sv = (1-cn+n)*v(llsb:llsb+rgm,:) ... %lesser
        + (cn-n)*v(llsb+1:llsb+1+rgm,:); %greater
    end
  elseif 3==nd
    if cn-n == 0
      sv = v(llsb:llsb+rgm,:,:);
    else
      sv = (1-cn+n)*v(llsb:llsb+rgm,:,:) ... %lesser
        + (cn-n)*v(llsb+1:llsb+1+rgm,:,:); %greater
    end
  elseif 4==nd
    if cn-n == 0
      sv = v(llsb:llsb+rgm,:,:,:);
    else
      sv = (1-cn+n)*v(llsb:llsb+rgm,:,:,:) ... %lesser
        + (cn-n)*v(llsb+1:llsb+1+rgm,:,:,:); %greater
    end
  else
    if cn-n == 0
      sv = v(llsb:llsb+rgm,:);
    else
      sv = (1-cn+n)*v(llsb:llsb+rgm,:) ... %lesser
        + (cn-n)*v(llsb+1:llsb+1+rgm,:); %greater
    end

    sz = size(v);
    sv = reshape(sv,[size(sv,1) sz(2:end)]);
  end
end

if nargout==1
  oo=zeros(size(v));
  if isvector(v)
    oo(lb:rb)=sv;
  else
    so=size(sv);
    oo(lb:rb,:)=reshape(sv,[so(1) prod(so(2:end))]);
  end
  lb=oo;
end

end
