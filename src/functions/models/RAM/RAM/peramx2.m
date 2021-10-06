% peramx.m
% ram PE example
%
clear all; close all; clc
%compile the c programs 
% mex -O matrc.c
% mex -O solvetri.c
%%%%%%%
wedge=zeros(1001,1);
wedge(1:501)=5000;
for i=502:1001
wedge(i)=wedge(i-1)-100;
end
%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% *** set up Munk SSP ***
zw=0:1:5000;
zw=zw(:);
cw=cssprofile(zw);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%source depth
zsrc=1;
%source frequency
fc=100;
Q=4;
%time window 
T=3;
%src-rcvr range
%rmax=100000.0;
rg=0:10:10000;
wedgeint=interp1(wedge,(length(wedge)/length(rg)):(length(wedge)/length(rg)):length(wedge));
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
cw=cw';
cw=repmat(cw, nrp, 1);
%
%%clear xax delc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
c0=mean(cw(:));
rb=max(wedgeint)-min(wedgeint);
zb=wedgeint;
zb=max(zw)-400;
zs=0;
cs=1500*ones(nrp,1);
zs=zw;
cs=cw;
zr=0;
rho=1.0*ones(nrp,1);
zbm=max( zb);
za=[zbm+100 zbm+300];
attn=[0.5 100];
attn=ones(nrp,1)*attn;
clear zbm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
zmax=max(zw);
deltaz=1;
deltar=100;
np=4;
ns=1;
rs=10000.0;
%output depth decimation
%dzm=round(max(zw)/length(wedge));
dzm=5;
zg=[0:deltaz:zmax];
nzo=length(zg(1:dzm:end));
clear zg
% psif=complex(zeros( nzo, nf));
dim=2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ecputime=clock;
cput=cputime;
%psi=zeros(length(rg),length(rg),length(rg));
%for i=1:length(rg)
  [psi, psi2,zg, rout]=ram( fc,zsrc,dim,rg,deltar,zmax,deltaz,dzm,...
           c0,np,ns,rs,rb,zb,rp,zw,cw,zs,cs,zr,rho,za,attn);
  %tl(:,i)=psi;
%end
%tl=abs(20*log10(tl));
tl=abs(20*log10(psi));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name','Transmission Loss vs Range and Depth')
hold on
surf(rg,0:dzm:max(wedge),tl,'EdgeColor','none','LineStyle','none','FaceLighting','none')
%plot(1:length(rg),wedgeint,'k','LineWidth',2)
xlabel('Range (m)')
ylabel('Depth (m)')
xlim([0 length(rg)]);
shading interp;
caxis([0 60]);
colormap('default');
h = colorbar;
h2 = get(h, 'ylabel');
set(h2, 'string', 'Transmission Loss (dB)');
colormap('default');
Map = colormap;
colormap(flipud(Map));
view([0 -90])