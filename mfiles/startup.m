main()

function main()

format shortg
format compact

set(groot,'defaultAxesXGrid','on');
set(groot,'defaultAxesYGrid','on');
set(groot,'defaultAxesZGrid','on');
%set(groot,'defaultAxesXMinorGrid','on','defaultAxesXMinorGridMode','manual');
%set(groot,'defaultAxesYMinorGrid','on','defaultAxesYMinorGridMode','manual');
%set(groot,'defaultAxesZMinorGrid','on','defaultAxesZMinorGridMode','manual');

if ismac
    t_sizes = [18 14];
elseif isunix
    t_sizes = [14 12];
end

set(groot,'defaultAxesFontSize',t_sizes(1));
set(groot,'defaultLegendFontSize',t_sizes(1));
set(groot,'defaultLineMarkerSize',12);

set(groot,'defaultAxesLineWidth',1.5);
set(groot,'defaultColorbarLineWidth',1);
set(groot,'defaultLineLineWidth',2);
set(groot,'defaultfunctionLineLineWidth',2);

%set(groot,'defaultTiledlayoutPadding','loose','defaultTiledlayoutTileSpacing','loose')

if sum(strcmp(listfonts,'Go')) > 0 % My preferred font. Easier to see minus signs.
    set(groot,'defaultAxesFontName','Go');
end

if ~isempty(which('figDefaultKeyPress'))
  set(0, 'DefaultFigureKeyPressFcn', @figDefaultKeyPress);
end

end
