% [lb,rb,sv] = interpshift(n,v)
% Linearly interpolated shift of vector v by n, n may be noninteger.
% Returns shifted vector sv, and corresponding left (lb) & right (rb) index into v.
% If abs(n)>length(v), returns [0,0,[]].
% Also takes higher dimensional arrys. Operate on the 1st dimension.
function [lb,rb,sv] = interpshift(n,v)


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
