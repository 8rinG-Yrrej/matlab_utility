% function {meanabserr,meanrelerr,maxabserr,maxrelerr,sumrelerr}=functionError(f,g,[zerotol])
% Return statistics about the difference between vectors |f| and |g|.
% Default zero tolerance |zerotol| = 1/numel(f)/10;
function errorStruct=functionError(f,g,zerotol)

if nargin == 2
  zerotol = 1/numel(f)/10;
end

dfg=abs(f-g);
zz=(abs(f)+abs(g));
ind=zz>zerotol;
zz=dfg(ind)./zz(ind);

abserr=mean(dfg,'all');
% geometric mean to handle relative error. Use not `geomean` due to
% possibly dfg(ind)./mfg(ind)>1
% 1-rel% to favor large discrepency

relerr = 1-prod(1-zz,'all')^(1/numel(ind)); 
if isnan(relerr)
  relerr = 0;
end
maxabserr=max(dfg,[],'all');
maxrelerr = max(zz,[],'all');
if isempty(maxrelerr)
  maxrelerr=0;
end
sumrelerr = sum(zz,'all');


errorStruct.abserr = abserr;
errorStruct.relerr = relerr;
errorStruct.maxabserr = maxabserr;
errorStruct.maxrelerr = maxrelerr;
errorStruct.sumrelerr = sumrelerr;

end
