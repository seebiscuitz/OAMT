function [ surfaceobject ] = bathtosurf( varargin )
%BATHTOSURF Returns a surface object from input data using the linear
%interpolation method as default.
%   SURFOUT = BATHTOSURF(X,Y,Z) provides the linear interpolant to the data
%   values of Z at the data sites (X,Y) using the interp2 function.
%
%   Data set Z can be size [nxm] or size [n]. If Z is size [nxm] then X and
%   Y must be of size [n] and [m] respectively. If Z is of size [n] then X
%   and Y must be vectors of size [n]
%
%   SURFOUT = BATHTOSURF(...,METHOD) specifies alternative methods for the
%   interpolation technique used in calculating the surface object.
%   Available methods are as listed in the interp2 function;
%
%     'nearest' - nearest neighbor interpolation
%     'linear'  - bilinear interpolation
%     'spline'  - spline interpolation
%     'cubic'   - bicubic interpolation as long as the data is
%                 uniformly spaced, otherwise the same as 'spline'
%
%
%Load inputs
    xdata=varargin{1};
    ydata=varargin{2};
    zdata=varargin{3};
    method=varargin{4};
    res=varargin{5};
    %gr1=fix(vdist(min(xdata),min(ydata),max(xdata),min(ydata))/res);
    %gr2=fix(vdist(min(xdata),min(ydata),min(xdata),max(ydata))/res);
    %if gr1>gr2; gridsize=gr1; else gridsize=gr2; end
%Check Z size and set gridsize
    % need to change to accomodate for maximum possible array size
    % however, maximum arrray determined in bytes, need to find data type
    % to determine maximum array size.
    if max(size(zdata))<1500 
        gridsize=2*max(size(zdata));
    else
        gridsize=max(size(zdata));
    end  
%Create mesh grid
    v_x=linspace(min(xdata),max(xdata),gridsize);
    v_y=linspace(min(ydata),max(ydata),gridsize);
    [xq,yq]=meshgrid(v_x,v_y);
%Interpolate and save output
    % check input size to determine interpolation method
    a=size(zdata);
    if a(2)>1
        interpolateddata=interp2(xdata,ydata,zdata,xq,yq,method);
    else
        method=changemethod(method);
        interpolateddata=griddata(xdata,ydata,zdata,xq,yq,method);
    end
    surfaceobject=surf(xq,yq,interpolateddata,'EdgeColor','none','LineStyle','none','FaceLighting','phong');  
    surfaceobject.XData=xq;
    surfaceobject.YData=yq;
    surfaceobject.ZData=interpolateddata;
end

