function fig2clip

if verLessThan('matlab','9.10')
	print -clipboard -r600 -dbitmap
else
	copygraphics(gcf,'BackgroundColor','none') %'ContentType','vector'
end

end
