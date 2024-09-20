% function x = gA(y)
% if canUseGPU
%   x = gpuArray(y);
% else
%   x=y;
% end
% end
function x = gA(y)
persistent hascpu
if isempty(hascpu)
  if exist('canUseGPU') && canUseGPU
    hascpu=true;
  elseif 0 < gpuDeviceCount
    hascpu=true;
  else
    hascpu=false;
  end
end
if hascpu
  x = gpuArray(y);
else
  x=y;
end
end
