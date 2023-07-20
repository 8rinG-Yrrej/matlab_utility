% function fq(h)
% Clear graph and close graph window.
% Directly close window on mac often hangs up matlab.
function fq(h)
if nargin == 0
  h = gcf;
elseif strcmp(h,'all')
  h = get(groot,'Children');
end

if isscalar(h)
  clf(h);
  close(h);
else
  arrayfun(@fq,h);
end

end
