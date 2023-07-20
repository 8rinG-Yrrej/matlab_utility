function a = cellmask(fn,c)
%a = cellmask(fn,c)
% Return indices of cellarray |c| where fn(c{a})==true.
a=[];
for ii = 1:numel(c)
  if fn(c{ii})
    a=[a ii];
  end
end
end
