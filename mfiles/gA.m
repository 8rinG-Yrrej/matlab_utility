% function x = gA(y)
% if canUseGPU
%   x = gpuArray(y);
% else
%   x=y;
% end
% end
function x = gA(y)
if exist('canUseGPU') && canUseGPU
  x = gpuArray(y);
elseif 0 < gpuDeviceCount
  x = gpuArray(y);
else
  x=y;
end
end
