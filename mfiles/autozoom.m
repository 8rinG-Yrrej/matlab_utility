function [rng,irng]=autozoom(arg1,arg2,dis)
%AUTOZOOM returns the range of array indices that constitutes the
%nonzero bulk. Only for 2D plots.
% Returns the value range rng and index range irng
% Usage: [xRange,indexRange]=autozoom([x=1:length(y)],y,[eps=1e-4])
if nargin < 3
  dis=1e-4;
end
if nargin < 2
  y=arg1;
  x=1:length(arg1);
else
  y=arg2;
  x=arg1;
end

cs=cumsum(abs(y).*gradient(x));
cs=cs/cs(end);


l=find(cs>dis,1);
r=find(cs>1-dis,1);

irng=[l r];
rng=[x(l) x(r)];

rng=(1+sign(rng).*[-0.04 0.04]).*rng;

end
