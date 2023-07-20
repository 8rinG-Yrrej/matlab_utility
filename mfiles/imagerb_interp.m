% function imagerb_interp(x,y,z,[xmin xmax ymin ymax])
% function imagerb_interp(z)
% Plot with imagerb while interpolate to make axis linear

function imagerb_interp(arg1,arg2,arg3,arg4)

nn=3000;

if nargin == 1
  x=double(1:size(arg1,1));
  y=double(1:size(arg1,2));
  z=arg1;
elseif nargin == 3 || nargin == 4
  x=double(arg1);
  y=double(arg2);
  z=arg3;
else
  error('Usage error.')
end

if nargin < 4
  xylim=[min(x) max(x) min(y) max(y)];
else
  xylim0=[min(x) max(x) min(y) max(y)];
  xylim=arg4;
  xylim([1 3])=max(xylim([1 3]),xylim0([1 3]));
  xylim([2 4])=min(xylim([2 4]),xylim0([2 4]));
end

tointerp=false;
if ~isUniform(x) || xylim(1)~=min(x) || xylim(2)~=max(x)
  nx=linspace(xylim(1),xylim(2),nn);
  tointerp=true;
else
  nx=x;
end
if ~isUniform(y) || xylim(3)~=min(y) || xylim(4)~=max(y)
  ny=linspace(xylim(3),xylim(4),nn)';
  tointerp=true;
else
  ny=y;
end

if tointerp
  nz=interp2(x,y,z,nx,ny,'linear',0);
else
  nz=z;
end

imagerb(nx,ny,nz);

end
