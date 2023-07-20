function ds = unpack_struct(s,dest)
%ds=unpack_struct(s,[dest])
% Unpacks the fields of s and
%  1/ export to workspace when `dest` is absent. Return `s`.
%  2/ append it to structure `dest`. Returns appended `dest`.

if nargin == 1
  dest='caller';
  opmode="workspace";
elseif ischar(dest) || isstring(dest)
  opmode="workspace";
elseif isstruct(dest)
  opmode="struct";
end

vals = struct2cell(s);
names = fieldnames(s);

if opmode=="workspace"
  for ii = 1:length(vals)
    assignin(dest,names{ii},vals{ii});
  end
  if nargout > 0
    ds=s;
  end
elseif opmode=="struct"
  for ii = 1:length(vals)
    dest.(names{ii})=vals{ii};
  end
  ds=dest;
end

end
