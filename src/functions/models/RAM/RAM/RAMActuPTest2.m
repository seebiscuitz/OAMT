% peramx.m
% ram PE example
%
clear all; %close all; clc
clc
%compile the c programs 
% mex -O matrc.c
% mex -O solvetri.c
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
zw=0:1:10000;
zw=zw(:);
cw=1500;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%source depth
zsrc=75;
%source frequency
fc=50;
% 20km range, 100m steps
rmax=4000;
rslice=1000;
rg=rmax/rslice:rmax/rslice:rmax;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%range independent
rp=0;
nrp=length(rp);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
c0=mean(cw(:));
zb=linspace(200,0,rmax);
rb=0:rmax/rslice:rmax;
zs=zw;
cs=1700;%cs=1749;
zr=0;
rho=1500;
zbm=max(zb);
%za=200:-(200/rmax):0;
za=[max(zb)+1 max(zb)+2];
attn=[1e-10 2];
attn=ones(nrp,1)*attn;
clear zbm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%zmax=max(zb);
zmax=max(zb)+100;
%100m step
deltaz=1;
deltar=100;
np=8;
ns=1;
rs=10000.0;
dzm=1;
% psif=complex(zeros( nzo, nf));
dim=2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[psi, zg, rout]=ram( fc,zsrc,dim,rg,deltar,zmax,deltaz,dzm,...
           c0,np,ns,rs,rb,zb,rp,zw,cw,zs,cs,zr,rho,za,attn);
%tl=-20*log10(abs(psi)+1e-20);%10*log10(rout+1e-20);
%tl=bsxfun(@plus,-20*10.^(abs(psi)+1e-20),10*10.^(rout+1e-20));
tl=bsxfun(@plus,-20*log10(abs(psi)+1e-20),10*log10(rout+1e-20));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h1=figure('Name','Transmission Loss vs Range and Depth');
h=axes;
pcolor(h,rg,zg,tl);
shading interp;
caxis([20 80]);
colormap('default');
Map = colormap;
colormap(flipud(Map));
h = colorbar;
h2 = get(h, 'ylabel');
set(h2, 'string', 'Transmission Loss (dB)');
set(gca,'YDir','reverse')
xlabel('Range (m)'), ylabel('Depth (m)'), title('Transmission Loss')