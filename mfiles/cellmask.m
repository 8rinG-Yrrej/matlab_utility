function a = cellmask(fn,c)
%CELLMASK applies logical mask for cell arrays.
%a = cellmask(fn,c)
% Return indices of cell array |c| where fn(c{a})==true.
a=[];
for ii = 1:numel(c)
  if fn(c{ii})
    a=[a ii];
  end
end
end
