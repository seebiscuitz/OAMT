function plotEFlux(g1data,TL,surfobject,source,env)
    TL=abs(TL);
    TL(TL==Inf)=NaN;
    % - plotting TL -
    if strcmp(get(g1data.bathypanel,'visible'),'on')
        set(g1data.bathypanel,'visible','off');
        set(g1data.tlpanel,'visible','on');
    end
    % h=findobj('type','surf');
    % if ~isempty(h)
    %     delete(h)
    % end
    axes(g1data.axes2)
    %pcolor(gca,surfobject.XData,surfobject.YData,TLSum);
    %set(0, 'DefaultFigureRenderer', 'zbuffer')
    %TL(TL>100)=100;
    %surfTL=surf(surfobject.XData,surfobject.YData,TL,'EdgeColor','none','LineStyle','none','FaceLighting','phong');
    %view(-120,30)
    if ~isempty(env)
        Lat=surfobject.XData(1,:);
        Lon=surfobject.YData(:,1);
        [~, indx1]=min(abs(Lat-(env.coords(1))));
        [~, indx2]=min(abs(Lat-(env.coords(2))));
        [~, indy1]=min(abs(Lon-(env.coords(3))));
        [~, indy2]=min(abs(Lon-(env.coords(4))));
        Lat=surfobject.XData(1,min(indx1,indx2):max(indx1,indx2));
        Lon=surfobject.YData(min(indy1,indy2):max(indy1,indy2),1);
        h=gca;
        tlsize=size(TL);
        tl1=tlsize(1);
        tl2=tlsize(2);
        v_lat=linspace(min(Lat),max(Lat),tl1);
        v_lon=linspace(min(Lon),max(Lon),tl2);
        [Lat,Lon]=meshgrid(v_lon,v_lat);
        pcolor(h,Lon,Lat,TL);
    else
        h=gca;
        pcolor(h,surfobject.YData,surfobject.XData,abs(TL));    
    end
    shading interp;
    caxis([0 max(max(TL))]);
    colormap('default');
    Map = colormap;
    colormap(flipud(Map));
    h = colorbar;
    h2 = get(h, 'ylabel');
    set(h2, 'string', 'Transmission Loss (dB)');
    set(gca,'YDir','reverse')
    xlabel(sprintf('Latitude%c', char(176)));ylabel(sprintf('Longitude%c', char(176)));%zlabel('Transmission Loss(dB)');
    set(g1data.transloss_export,'Enable','on');
    hold on
    plot(str2double(source.longitude),str2double(source.latitude),'g^')
    % - end -
end