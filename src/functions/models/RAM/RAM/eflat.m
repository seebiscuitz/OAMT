function [depf, csf]=eflat( dep, lat, cs)
% function [depf, csf]=eflat( dep, lat, cs);
% flat earth transformation
% change depths and sound speeds so that spherical shell can be
% done as an x-z slice (using WGS-84)
%

dep=dep(:);
lat=lat(:);

if nargin<3
  cs=zeros(size(dep));
end
cs=cs(:);

% WGS-84 parameters
wgsa=6378137.0; wgsb=6356752.314;
wgsfact=(wgsb/wgsa)^4; Re=wgsa;
wgsa=wgsa*wgsa; wgsb=wgsb*wgsb;

ll=pi*lat/180.0;
ree1=wgsa./sqrt(wgsa*cos(ll).*cos(ll)+wgsb*sin(ll).*sin(ll));
re=ree1.*sqrt(cos(ll).*cos(ll)+wgsfact*sin(ll).*sin(ll));

E=dep./re;
depf=dep.*(1.0 + E.*(0.50 + E/3.0));
csf=cs.*(1.0+E.*(1.0+E));

return
