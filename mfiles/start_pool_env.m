function [pool,nreq] = start_pool_env(maxcpu)

if nargin < 1
  maxcpu = inf;
end

nev = getenv('MATLAB_NCPU');

if isempty(nev)
  nev=inf;
else
  nev=str2double(nev);
end

nreq = min(maxcpu,nev);

if isfinite(nreq)
  pool=parpool(nreq);
else
  pool=parpool();
end

end
