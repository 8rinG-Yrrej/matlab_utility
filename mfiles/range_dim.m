function s = range_dim(a,rng,d)
%RANGE_DIM is array indexing at a given dimension for arrays of indefinite total dimension.
% function s = range_dim(a,rng,d)
% Return s = a(...,rng,...) where rng appears at the |d|th dimension of a
w = ndims(a);
if d>w || d<1
  s=[];
else
  c1 = repmat(':',1,d-1);
  c2 = repmat(':',1,w-d);
  c = [num2cell(c1) {rng} num2cell(c2)];
  s = a(c{:});
end
end
