function cmap_angle_demo
%cmap_angle_demo demo of cmap_angle for a phase plot of z=x+1i*y.
% Note that angle(0)=0 by matlab.
%
% See also: cmap_angle setcolormap_angle

x=linspace(-1,1,101);
y=linspace(-1,1,101)';
z=angle(x+1i*y);

figure
s=pcolor(x,y,z);
set(s,'EdgeAlpha',0);
setcolormap_angle(z);
axis square
axis xy
xlabel x
ylabel y

end
