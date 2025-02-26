function pretty_fig
% make figure nice in general

if ismac
  sizes = [18 14];
	lwmin = 2;
elseif isunix
  sizes = [14 12];
	lwmin=2;
else
  sizes = [14 12];
	lwmin=2;
end

set(gca,'FontSize',sizes(1));

for ii = findobj(gca, 'Type','legend')
  set(ii,'FontSize',sizes(1));
end

gcaCh = get(gca,'Children');
for ii = 1:length(gcaCh)
  if contains(gcaCh(ii).Type,"line") || contains(gcaCh(ii).Type,"Line") || contains(gcaCh(ii).Type,"errorbar") || contains(gcaCh(ii).Type,"scatter")
    g = get(gcaCh(ii),'LineWidth');
		
    if g < lwmin
      set(gcaCh(ii),'LineWidth',lwmin);
    end
  end
end

% for ii = findobj(gca, 'Type','line')
%     set(ii,'MarkerSize',sizes(2));
% end

set(gca,'LineWidth',1.5);

%pos = get(gcf,'OuterPosition');
%set(gcf,'OuterPosition',[pos(1) pos(2) 490 500]);
set(gcf,'Color','w');

set(gca,'XMinorGrid','on');set(gca,'YMinorGrid','on');set(gca,'ZMinorGrid','on');
%axis square

end
