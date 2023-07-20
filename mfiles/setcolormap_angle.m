function setcolormap_angle(arg1,arg2,arg3,arg4)
%SETCOLORMAP_ANGLE sets colormap for periodic phase angle data.
% setcolormap_angle([ax],data)
% setcolormap_angle([ax],data,lmin,lmax)
% The colormap is set to cmap_angle.
% By default, ax=gca, lmin=-pi, lmax=pi.
%
% Example:
%   f = exp(1./((-2:0.001:2)+1i*(2:-0.001:-2)'));
%   subplot(1,2,1)
%   imagesc(angle(f))
%   setcolormap_angle(angle(f));
%   colorbar
% 
%   subplot(1,2,2)
%   imagesc(angle(f.^0.01))
%   setcolormap_angle(angle(f.^0.01));
%   colorbar
%
% See also: cmap_angle_demo cmap_angle

if 1 == nargin
  ax=gca;
  data=arg1;
  lmin=-pi;
  lmax=pi;
elseif 2 == nargin
  ax=arg1;
  data=arg2;
  lmin=-pi;
  lmax=pi;
elseif 3 == nargin
  ax=gca;
  data=arg1;
  lmin=arg2;
  lmax=arg3;
elseif 4 == nargin
  ax=arg1;
  data=arg2;
  lmin=arg3;
  lmax=arg4;
end


colmap=cmap_angle(data,lmin,lmax);

[a,b]=bounds(data,'all');

colormap(ax,colmap)

end
