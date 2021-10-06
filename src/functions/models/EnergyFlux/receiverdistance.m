function [ r ] = receiverdistance( H, source, lat, lon, dpm )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    switch dpm
        case 'negative'
            modifier=-1;
        otherwise
            modifier=1;
    end
    % - non paralllel toolbox -
    H=modifier.*H;
    n=size(H);
    n1=n(1);
    n2=n(2);
    r=zeros(n1,n2);
    SrcLat=str2double(source.latitude);
    SrcLon=str2double(source.longitude);
    %recdepthwait=waitbar(0,sprintf('Calculating receiver distancce 0/%d',n));
    for i=1:n1
        %fprintf('%d ',i)
        %waitbar(i/n,recdepthwait,sprintf('Calculating receiver distancce %d/%d',i,n));
        for j=1:n2
            if H(i,j)<0
                r(i,j)=-1;
            else
                r(i,j)=vdist(SrcLat,SrcLon,lat(i),lon(j));
            end
        end
    end
    %delete(recdepthwait);
    % - end -
end

