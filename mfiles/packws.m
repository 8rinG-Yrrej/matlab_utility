%PACKWS packs all variables in the workspace to struct |PACKWS_SV|
% Similar to save without writing to disk. Uses also |PACKWS_ZWN|, cleared
% at the end.
% See also EXPORT_STRUCT.
PACKWS_ZWN=whos;
PACKWS_SV=[];
for ii = 1:length(PACKWS_ZWN)
  PACKWS_SV.(PACKWS_ZWN(ii).name)=eval(PACKWS_ZWN(ii).name);
end
clearvars PACKWS_ZWN;
