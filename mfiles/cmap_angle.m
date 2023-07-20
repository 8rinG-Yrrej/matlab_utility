function cmap = cmap_angle(data,lmin,lmax)
%CMAP_ANGLE return a NIST hsv colormap, useful for displaying angles or
%other periodic data. It switches to 
% cmap_angle(data,lmin,lmax) with lmin=-pi, lmax=pi by default.
%
% Usage example:
%  f = exp(1./((-2:0.001:2)+1i*(2:-0.001:-2)'));
%  imagesc(angle(f))
%  colormap(cmap_angle(angle(f)));
%  colorbar
%
% See also: cmap_angle_demo setcolormap_angle

if nargin == 1
  lmin=-pi;
  lmax=pi;
end

colmap=cmapnist;
lc = size(colmap,1);

ll = (min(data,[],'all')-lmin)/(lmax-lmin);
rr = (max(data,[],'all')-lmin)/(lmax-lmin);

ll=max(floor(lc*ll),1);
rr=min(ceil(lc*rr),lc);

cmap = colmap(ll:rr,:);

end

%%
function [colmap] = cmapnist
%CMAPNIST returns a NIST compilant phase angle colormap.
% Copied from PHASE PLOT code by Elias Wegert.

cmap=hsv(900);
colmap(1:150,:)=cmap(1:150,:);
colmap(151:300,:)=cmap(151:2:450,:);
colmap(301:450,:)=cmap(451:600,:);
colmap(451:600,:)=cmap(601:2:900,:);

end
