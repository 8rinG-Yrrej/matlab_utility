function oo=gAzeros(varargin)
%gAzeros return zeros of gpu Array of type double.
%  Returns cpu array if gpuDeviceCount<1.
% zm = gAzeros(l1,l2,l3,...)
% zm = gAzeros([l1 l2 l3])
if gpuDeviceCount < 1
  oo = zeros(varargin);
else
  if length(varargin)==1 && isvector(varargin{1})
    ss = varargin{1};
  else
    ss = cell2mat(varargin);
  end
  oo = zeros(ss,'gpuArray');
end

end
