function [  ] = plotsurface( plotdata, xq, yq)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    hold on
    surf(plotdata.xdata,plotdata.ydata,plotdata.zdata,'EdgeColor','none','LineStyle','none','FaceLighting','phong');  
    view(-120,30)
    xlabel(sprintf('Latitude%c', char(176)));ylabel(sprintf('Longitude%c', char(176)));zlabel('Depth(m)');
    quiver3(xq.xcord,xq.ycord,xq.zcord,xq.diff,0,0,0)
    text(xq.med,xq.ycord,xq.zcord,[num2str(xq.dist) ' km'],'color','b')
    quiver3(yq.xcord,yq.ycord,yq.zcord,0,yq.diff,0,0)
    text(yq.xcord,yq.med,yq.zcord,[num2str(yq.dist) ' km'],'color','r')
    grid on
end

