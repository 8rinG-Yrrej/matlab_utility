function ss = clearfield(S,nms)

tf=isfield(S,nms);
ss=S;

if ischar(nms)
  if tf
    ss=rmfield(ss,nms);
  end
  return
end

if iscell(nms)
  for ii=numel(tf)
    if tf(ii)
      ss=rmfield(ss,nms{ii});
    end
  end
else
  for ii=numel(tf)
    if tf(ii)
      ss=rmfield(ss,nms(ii));
    end
  end
end

end
