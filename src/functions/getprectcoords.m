function [ coords ] = getprectcoords(SrcLat,SrcLon,profno,surfobject)
%GETPRECTCOORDS Generrates coordicates for next profile retangle 
    %Detailed explanation goes here
    lat=surfobject.XData(1,:);
    lon=surfobject.YData(:,1);
    maxzd=max(max(surfobject.ZData));
    minzd=min(min(surfobject.ZData));
    initialcoords=[[SrcLat,SrcLon,maxzd];[lat(1),max(lon),maxzd];[lat(1),max(lon),minzd];[SrcLat,SrcLon,minzd];[SrcLat,SrcLon,maxzd]];
    sizematrix=size(surfobject.ZData); noprofs=2*sizematrix(1)+2*sizematrix(2)-4;
    coords=zeros(noprofs,2);
    for i=1:noprofs
        if i>length(surfobject.ZData) && i<2*length(surfobject.ZData)
            coords(i,:)=[max(lat),lon(end-i)];
        elseif i>2*length(surfobject.ZData) && i<3*length(surfobject.ZData)
            coords(i,:)=[lat(end-i),min(lon)];
        elseif i>2*length(surfobject.ZData) && i<3*length(surfobject.ZData)
            
        else
            coords(i,:)=[lat(i),max(lon)];
        end
    end
    coords=coords(profno,:);
end