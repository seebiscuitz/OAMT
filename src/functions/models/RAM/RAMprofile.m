function [ profM, rngM, coordsmatrix ] = RAMprofile( H, source, lat, lon )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    [~, idy]=min(abs(lat-str2double(source.latitude)));     % idy is source row
    [~, idx]=min(abs(lon-str2double(source.longitude)));    % idx is source column
    rspace=vdist(lat(1),lon(1),lat(1),lon(2));
    cspace=vdist(lat(1),lon(1),lat(2),lon(1));
    maxprofL=getmaxprof(length(H),idx,idy);
    sizeH=size(H);
    sH1=sizeH(1);sH2=sizeH(2);
    nprof=((sH1+sH2)*2)-4;
    rngM=zeros(nprof,1);
    profM=zeros(nprof,maxprofL);
    coordsmatrix=zeros(nprof,2);
    warning('off','all')
    % - profile calculation -
    k=1;
    for i=1:sH1
       j=1;
       [prof, rng]=getprofile(H,idx,idy,i,j,rspace,cspace); 
       dims=size(prof);
       if dims(1)==1; prof=prof'; end
       profM(k,:)=[-1.*prof;NaN.*ones(maxprofL-length(prof),1)];
       rngM(k)=abs(rng);
       coordsmatrix(k,:)=[lat(i),max(lon)];
       k=k+1;
    end
    for j=2:sH2-1
       [prof, rng]=getprofile(H,idx,idy,i,j,rspace,cspace); 
       dims=size(prof);
       if dims(1)==1; prof=prof'; end
       profM(k,:)=[-1.*prof;NaN.*ones(maxprofL-length(prof),1)];
       rngM(k)=abs(rng);
       coordsmatrix(k,:)=[max(lat),lon(end-j)];
       k=k+1;
    end
    for i=sH1:-1:1
       j=length(H);
       [prof, rng]=getprofile(H,idx,idy,i,j,rspace,cspace); 
       dims=size(prof);
       if dims(1)==1; prof=prof'; end
       profM(k,:)=[-1.*prof;NaN.*ones(maxprofL-length(prof),1)];
       rngM(k)=abs(rng);
       coordsmatrix(k,:)=[lat(i),min(lon)];
       k=k+1;
    end
    for j=sH2-1:-1:2
       [prof, rng]=getprofile(H,idx,idy,i,j,rspace,cspace); 
       dims=size(prof);
       if dims(1)==1; prof=prof'; end
       profM(k,:)=[-1.*prof;NaN.*ones(maxprofL-length(prof),1)];
       rngM(k)=abs(rng); 
       coordsmatrix(k,:)=[min(lat),lon(end-j+1)];
       k=k+1;
    end
    % - end -
    warning('on','all')
end