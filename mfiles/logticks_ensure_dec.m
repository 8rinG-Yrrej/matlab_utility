% function logticks_ensure_dec(ax)
% Matlab sometimes skip a decade or more in logarithmic axis.
% This function ensures that no decade is skipped, in all of the
% logscale axes.
function logticks_ensure_dec(ax)

if nargin == 0
  ax = gca;
end

if ~isscalar(ax)
  arrayfun(@logticks_ensure_dec,ax);
end

if strcmp(get(ax,'XScale'),'log')
  axs = axis(ax);
  xt = xticks(ax);
  dd = get_dec(axs(1), axs(2));
  nxt = unique(sort([xt dd]));
  if length(xt) < length(nxt)
    xticks(ax,nxt);
  end
end

if strcmp(get(ax,'YScale'),'log')
  axs = axis(ax);
  yt = yticks(ax);
  dd = get_dec(axs(3), axs(4));
  nyt = unique(sort([yt dd]));
  if length(yt) < length(nyt)
    yticks(ax,nyt);
  end
end

end

function dd = get_dec(a,b)
dd = 10.^(ceil(log10(a)):floor(log10(b)));
end
