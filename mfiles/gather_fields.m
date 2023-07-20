function sn = gather_fields(s)

fns=fieldnames(s);
for ii = 1:length(fns)
  sn.(fns{ii}) = gather(s.(fns{ii}));
end

end
