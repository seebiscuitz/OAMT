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
% *** set up Munk SSP ***
zw=0:1:5000;
zw=zw(:);
%cw=cssprofile(zw);
%1500 sound speed
cw=1500;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%source depth
zsrc=75;
%source frequency
fc=50;
% 20km range, 100m steps
rg=0:1:4000;
rmax=max(rg);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%range independent
% cw=cw';
rp=0;
nrp=length(rp);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%range dependent
%rp=xax;
%nrp=length(rp);
% cw=cw';
% cw=repmat(cw, nrp, 1);
%
%%clear xax delc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
c0=mean(cw(:));
rb=1:rmax;
%10km depth
zb=500;
zb=linspace(200,0,rmax);
zs=zw;
cs=1700;
zr=0;
rho=1500;
zbm=max(zb);
za=[zbm zbm+400];
attn=[1e-10 0];
attn=ones(nrp,1)*attn;
clear zbm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
zmax=max(zb)+150;
%100m step
deltaz=1;
deltar=10;
np=6;
ns=1;
rs=10000.0;
%output depth decimation
%dzm=round(max(zw)/length(wedge));
dzm=1;
zg=[0:deltaz:zmax];
nzo=length(zg);
clear zg
% psif=complex(zeros( nzo, nf));
dim=2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%psi=zeros(length(rg),length(rg),length(rg));
  [psi, zg, rout]=ram( fc,zsrc,dim,rg,deltar,zmax,deltaz,dzm,...
           c0,np,ns,rs,rb,zb,rp,zw,cw,zs,cs,zr,rho,za,attn);
%tl=-20*log10(abs(psi)+1e-20);%10*log10(rout+1e-20);
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