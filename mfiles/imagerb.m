% function imagerb(x,y,z)
% function imagerb(z)
% Originally by Yashar Komijani
% Similar to imagesc but using red(+)-white(0)-blue(-) colormap returned by
% cmaprb.

function fh=imagerb(arg1,arg2,arg3)

if nargin == 1
    h=imagesc(arg1);
    axis xy
    cm = cmaprb(arg1);
    colormap(gca,cm);
    colorbar
elseif nargin == 3
    h=imagesc(arg1,arg2,arg3);
    axis xy
    cm = cmaprb(arg3);
    colormap(gca,cm);
    colorbar
else
    error('Usage error.')
end

if nargout>0
  fh=h;
end

end
