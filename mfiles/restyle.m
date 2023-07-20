function restyle(styles)
%RESTYLE(styles={'-','--',':','-.'})
% function restyle(styles={'-','--',':','-.'})
% Restyle lines in current plot

ow = get(gca,'Children');
w=ow(arrayfun(@desired_child,ow));
w=flip(w);

if nargin==0
  styles={'-','--',':','-.'};
end

ns = length(styles);

for ii=1:length(w)
  set(w(ii),'LineStyle',styles(mod(ii-1,ns)+1));
end

end

%%

function t = desired_child(gl)
lt = gl.Type;

if strcmp(lt,'line') || strcmp(lt,'errorbar') %|| strcmp(lt,'scatter')
  t=true;
else
  t=false;
end
end
