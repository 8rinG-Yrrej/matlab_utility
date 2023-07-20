function aa=allaxes(fh)
%ALLAXES gets handle for all axes in figure handle fh, including children
% of tiledlayout.

if nargin == 0
  fh=gcf;
end

aa=[];
for ii = 1:length(fh.Children)
  w=fh.Children(ii);
  if strcmp(w.Type,'axes')
    aa=[aa;w];
  elseif strcmp(w.Type,'tiledlayout')
    aa=[aa;allaxes(w)];
  end
end

end
