function [dep, cs]=eflatinv( depf, lat, csf)
% function [dep, cs]=eflatinv( depf, lat, csf);
%  inverse flat earth transformation
%

depf=depf(:);
lat=lat(:);

if nargin<3
  csf=zeros(size(depf));
end
csf=csf(:);

% WGS-84 parameters
wgsa=6378137.0; wgsb=6356752.314;
wgsfact=(wgsb/wgsa)^4; Re=wgsa;
wgsa=wgsa*wgsa; wgsb=wgsb*wgsb;

ll=pi*lat/180.0;
ree1=wgsa./sqrt(wgsa*cos(ll).*cos(ll)+wgsb*sin(ll).*sin(ll));
re=ree1.*sqrt(cos(ll).*cos(ll)+wgsfact*sin(ll).*sin(ll));

zacc=0.001*ones(size(depf));

dep=ridder( @eflat, depf-5, depf, depf, zacc, lat);

E=dep./re;
cs=csf./(1.0+E.*(1.0+E));

return