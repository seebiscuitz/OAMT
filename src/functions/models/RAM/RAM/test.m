% - bathymetry -
wedge=zeros(1001,1);
wedge(1:501)=5000;
for i=502:1001
wedge(i)=wedge(i-1)-100;
end
% - end -

% - variables -
frq=1000;% frq		frequency
zsrc=10;% zsrc		source depth
dim=2;% dim		2-d starter (dim=2) or 3-d starter (dim=3)
% rg		vector of output ranges
% dr    	range step
zmax=max(wedge);% zmax  	max depth
% dz    	depth grid increment
% dzm           decimate output depth grid (dzm=1, no decimation)
% c0    	"mean" sound speed
% np    	# of pade coefficients
% ns    	# of stability terms
% rs    	stability range
% rb		bathymetry range 
% zb		bathymetry
% rp 		profile ranges(nr)
% zw    	sound speed grid depth(nzw)
% cw    	sound speed(nr,nzw)
% zs    	sediment speed grid depth(nzs)
% cs    	sediment speed(nr,nzs)
% zr		density depth grid(nzr)
% rho		density(nr,nzr)
% za		attenuation depth grid(nza)
% attn		attenuation(nr,nza)



[psi, psi2,zg, rout]=ram( fc,zsrc,dim,rg(i),deltar,zmax,deltaz,dzm,...
           c0,np,ns,rs,rb,zb,rp,zw,cw,zs,cs,zr,rho,za,attn);