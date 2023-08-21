function xrng=set_autozoom(ah)
%SET_AUTOZOOM sets current or given axis to |autozoom|'ed x-range for 2D
%plots.
% xrng=set_autozoom(ah)

if nargin<1
  ah=gca;
end

ro=[];
xl=nan; xr=nan;
for ii=ah(:).'
  s=get(ii,'Children');
  for jj=s(:)'
    if desired_child(jj)
      xx=autozoom(get(jj,'XData'),get(jj,'YData'));
      if ~isnan(xl); xl=min(xl,xx(1)); else; xl=xx(1); end
      if ~isnan(xr); xr=max(xr,xx(2)); else; xr=xx(2); end
    end
  end
  axis(ii,[xl xr -inf inf]);
end

if nargout>0
  xrng = [xl xr];
end

end



function t = desired_child(gl)
lt = gl.Type;

if strcmp(lt,'line') || strcmp(lt,'errorbar') || strcmp(lt,'scatter')
  t=true;
else
  t=false;
end
end
