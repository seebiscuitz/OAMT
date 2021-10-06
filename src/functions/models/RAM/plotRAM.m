function plotRAM(handles, sourcearray, surfobject)
    % - plotting original data and creating dropdown string -
    if strcmp(get(handles.bathypanel,'visible'),'on')
    set(handles.bathypanel,'visible','off');
    set(handles.tlpanel,'visible','on');
    end
    axes(handles.axes2);
    cla(handles.axes2);
    surfTL=surf(surfobject.XData,surfobject.YData,surfobject.ZData,'EdgeColor','none','LineStyle','none','FaceLighting','phong');
    view(-120,30)
    xlabel(sprintf('Latitude%c', char(176)));ylabel(sprintf('Longitude%c', char(176)));zlabel('Depth (m)');
    set(handles.transloss_export,'Enable','on');
    set(handles.create_path,'Enable','on');
    % - end -
    % - trancest rectangle for first source -
    lat=surfobject.XData(1,:);
    lon=surfobject.YData(:,1);
    maxzd=max(max(surfobject.ZData));
    minzd=min(min(surfobject.ZData));
    for i=1:length(sourcearray)
        SrcLat=str2double(sourcearray(i).latitude);
        SrcLon=str2double(sourcearray(i).longitude);
        hold on
        plot3(SrcLat,SrcLon,-1*str2double(sourcearray(i).depth),'k^')
        prect=[[SrcLat,SrcLon,maxzd];[lat(1),max(lon),maxzd];[lat(1),max(lon),minzd];[SrcLat,SrcLon,minzd];[SrcLat,SrcLon,maxzd]];
        line(prect(:,1),prect(:,2),prect(:,3),'color','r','Linewidth',2)
    end
    % - end -
end