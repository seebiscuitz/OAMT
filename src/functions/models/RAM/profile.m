function [ profM, rngM ] = RAMprofile( H, source, lat, lon )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    [~, idy]=min(abs(lat-str2double(source.latitude)));     % idy is source row
    [~, idx]=min(abs(lon-str2double(source.longitude)));    % idx is source column
    rspace=vdist(lat(1),lon(1),lat(1),lon(2));
    cspace=vdist(lat(1),lon(1),lat(2),lon(1));
    maxprofL=getmaxprof(length(H),idx,idy);
    nprof=4*length(H)-4;
    rngM=zeros(nprof,1);
    profM=zeros(nprof,maxprofL);
    warning('off','all')
    % - profile calculation -
    k=1;
    for i=1:length(H)
       j=1;
       [prof, rng]=getprofile(H,idx,idy,i,j,rspace,cspace); 
       k=k+1;
       profM(k,:)=[prof; -1.*ones(maxprofL-length(prof),1)];
       rngM(k)=rng;
    end
    for j=2:length(H)-1
       [prof, rng]=getprofile(H,idx,idy,i,j,rspace,cspace); 
       k=k+1;
       profM(k,:)=[prof; -1.*ones(maxprofL-length(prof),1)];
       rngM(k)=rng;
    end
    for i=length(H):-1:1
       j=length(H);
       [prof, rng]=getprofile(H,idx,idy,i,j,rspace,cspace); 
       k=k+1;
       profM(k,:)=[prof; -1.*ones(maxprofL-length(prof),1)];
       rngM(k)=rng;
    end
    for j=length(H)-1:-1:2
       [prof, rng]=getprofile(H,idx,idy,i,j,rspace,cspace); 
       k=k+1;
       profM(k,:)=[prof; -1.*ones(maxprofL-length(prof),1)];
       rngM(k)=rng; 
    end
    % - end -
    warning('on','all')
end