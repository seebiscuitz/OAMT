function [ data, xq, yq ] = decimateplot( surfobj,step )
%DECIMATEPLOT Returns scaled surf by step. Also returns quiver data.
%   Detailed explanation goes here
    % surf object
    data.xdata=surfobj.XData(1:step:end,1:step:end);
    data.ydata=surfobj.YData(1:step:end,1:step:end);
    data.zdata=surfobj.ZData(1:step:end,1:step:end);
    %x quiver
    xq.xcord=min(data.xdata(1,:));      %min xdata
    %xq.ycord=max(data.ydata(:,1))+0.5;  %max ydata
    xq.ycord=max(data.ydata(:,1));%+0.1*max(data.ydata(:,1));  %max ydata
    xq.zcord=min(min(data.zdata));      %min zdata
    xq.diff=(max(data.xdata(1,:)))-xq.xcord;
    xq.med=median(data.xdata(1,:));     %median xdata
    %y quiver 
    %yq.xcord=xq.xcord-0.5;  %min xdata
    yq.xcord=xq.xcord;%-0.1*min(data.xdata(1,:));  %min xdata
    yq.ycord=min(data.ydata(:,1));      %min ydata
    yq.zcord=xq.zcord;      %min zdata
    yq.diff=(max(data.ydata(:,1)))-yq.ycord;
    yq.med=median(data.ydata(:,1));     %median ydata
    % distances
    xq.dist=round(vdist(xq.xcord,yq.ycord,max(data.xdata(1,:)),yq.ycord)/10^3);
    yq.dist=round(vdist(yq.xcord,yq.ycord,yq.xcord,xq.ycord)/10^3);
end

