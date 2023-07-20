% function tiledfig_resize([fig_handle=gcf],[w=400])
% Resize a figure to about w-by-w for each tile.
function tiledfig_resize(ag1,ag2)
if nargin == 0
  f = gcf;
  l = 400;
elseif nargin == 1
  f = gcf;
  l = ag1;
else
  f = ag1;
  l = ag2;
end

cc = get(f,'Children');
tl = [1 1];
for ii = 1:length(cc)
  if strcmp(get(cc(ii),'Type'), 'tiledlayout')
    tl = flip(get(cc(ii),'GridSize'));
  end
end

global SUBPLOT_ROW
global SUBPLOT_COL
if ~isempty(SUBPLOT_ROW) && ~isempty(SUBPLOT_COL)
  tl = [SUBPLOT_COL SUBPLOT_ROW];
end

pos = get(f,'InnerPosition');
set(f,'InnerPosition',[30 30 [l l*0.9].*tl]);

end
