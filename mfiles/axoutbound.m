function oo=axoutbound(ax,l0)
%AXOUTBOUND ensures that axis range does not exceed a max span.
% ax_handle=axoutbound([ax_handle],minspan)
% When all(minspan==[-inf inf -inf inf]), it is no-op.
if nargin == 1
  l0=ax;
  ax=gca;
end

if nargout>0
  get_oo=true;
else
  get_oo=false;
end

if get_oo; oo=[]; end
for ii = ax(:).'
  aa = axis(ii);
  ll=l0;
  ll(1:2:end) = max([aa(1:2:end); ll(1:2:end)],[],1);
  ll(2:2:end) = min([aa(2:2:end); ll(2:2:end)],[],1);
  axis(ii,ll);
  if get_oo; oo=[oo;axis(ii)]; end
end

end
