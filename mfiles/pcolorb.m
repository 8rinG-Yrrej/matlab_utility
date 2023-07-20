% function h = pcolorb(x,y,v)
% function h = pcolorb(v)
% x, y must be sorted, low to high

function hh = pcolorb(x,y,v)

switch nargin
  case 1
    v = x;
    x = 1:size(v,2);
    y = (1:size(v,1))';
  case 3
    % make sure x is row vector
    % y is column vector
    if isvector(y) && ~iscolumn(y)
      y=y';
    end
    if isvector(x) && iscolumn(x)
      x=x';
    end
  otherwise
    error('Usage error.')
end


if size(x,2)>1
  xm = (x(:,1:end-1)+x(:,2:end))/2;
  x = [1.5*x(:,1)-0.5*x(:,2)  xm  1.5*x(:,end)-0.5*x(:,end-1)];
  ym = (y(1:end-1,:)+y(2:end,:))/2;
  y = [1.5*y(1,:)-0.5*y(2,:); ym; 1.5*y(end,:)-0.5*y(end-1,:)];
  v = [v v(:,end)];
  v = [v;v(end,:)];
else
  x=[x x];
  v=[v v];
end

h=pcolor(x,y,v);
set(gca,'layer','top');

colormap(gca,cmaprb(v));
colorbar
h.EdgeAlpha = 0;

if nargout > 0
  hh=h;
end

end
