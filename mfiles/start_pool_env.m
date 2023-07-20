function [pool,nreq] = start_pool_env(maxcpu)
%START_POOL_ENV read from environment and set parallel pool cpu number. Useful for cluster jobs.
if nargin < 1
  maxcpu = inf;
end

nev = getenv_ncpu;

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
