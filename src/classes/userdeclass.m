classdef userdeclass
    properties
        sourcelabel;
        cas;
        xrange;
        yrange;
        coords;
    end
    methods
        function obj=userdeclass(sourcelabel,cas,xrange,yrange,coords)
            if nargin==5
                obj.sourcelabel=sourcelabel;
                obj.cas=cas;
                obj.xrange=xrange;
                obj.yrange=yrange;
                obj.coords=coords;
            end
        end
    end
end