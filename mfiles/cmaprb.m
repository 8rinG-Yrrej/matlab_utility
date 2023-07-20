% function cm=cmaprb(zz,[ncolor=8000])
% Originally by Yashar Komijani.
% Return a colormap cm based on data zz. The colors are
% red(+)-white(0)-blue(-).
function cm=cmaprb(zz,nc)

if nargin < 2
  nc=2000;
end

zl=min(zz,[],'all');
zr=max(zz,[],'all');
if zl==0 && zr==0
  r=[1 1];
  g=r; b=r;
elseif zl>=0 || (zl*zr<0 && -zl/zr<10/nc) % data (almost) all positive
  [r,g,b] = posc(zl/zr,nc);
elseif zr<=0 || (zl*zr<0 && -zr/zl<10/nc) % data (almost) all negative
  [r,g,b] = negc(zr/zl,nc);
else
  ncr=round(nc*(zr/(zr-zl)));
  [rr,gr,br]=posc(0,ncr);
  [rl,gl,bl]=negc(0,nc-ncr);
  r=[rl rr(2:end)];
  g=[gl gr(2:end)];
  b=[bl br(2:end)];
end

cm=[r' g' b'];
cm(cm<0)=0;
cm(cm>1)=1;
cm(isnan(sum(cm,2)),:)=0;

end


function [r,g,b] = posc(l,nc)
% [r,g,b] = posc(l,nc) color for positive part. l=min/max of data
  r = 1-linspace(l,1,nc)/2;
  g = 1-2*linspace(l,1,nc);
  g(g<0)=0;
  b = g;
end
function [r,g,b] = negc(rr,nc)
% [r,g,b] = negc(l,nc) color for negative part. r=max/min of data
r = linspace(0,1-rr,nc);
g = linspace(0,1-rr,nc);
b = ones(size(r));
end

function cm=oldfunc(zz,nc)
% Yashar's code, mutatis mutandis
c=linspace(0,1,nc);
% negative fraction, zero location
c0=-min(zz,[],'all')/(max(zz,[],'all')-min(zz,[],'all'));
if c0<1
  rc=(c-c0)/(1-c0);
else
  rc=-1;
end
c0=max(c0,eps);

disp([c0])

blue=(1-2*rc).*(c>c0)+1.*(c<=c0); blue=blue.*(blue>0); 
red=(1/c0)*c.*(c<c0)+(1-rc/2).*(c>=c0); red=red.*(red>0); 
green=(1/c0)*c.*(c<c0)+(1-2*rc).*(c>=c0); green=green.*(green>0); 


cm=[red' green' blue'];
cm(cm<0)=0;
cm(cm>1)=1;
end
