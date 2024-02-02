% gradient1 computes gradient along 1st dimension only
function y=gradient1(x)
if isvector(x) || isscalar(x)
  y=gradient(x);
else
  y=diff(x,1);
  y=cat(1,y(1,:),(y(2:end,:)+y(1:end-1,:))/2,y(end,:));
end

end
