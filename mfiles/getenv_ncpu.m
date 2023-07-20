function [nev] = getenv_ncpu()

sev = getenv('MATLAB_NCPU');

if isempty(sev)
  nev=65535;
else
  nev=str2double(sev);
end


end
