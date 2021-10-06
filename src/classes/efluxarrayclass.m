classdef efluxarrayclass   
    properties
        sourcelabel;
        tlarray;
    end
    
    methods
        function obj=efluxarrayclass(sourcelabel,tlarray)
            if nargin>0
                obj.sourcelabel=sourcelabel;
                obj.tlarray=tlarray;
            end
        end
    end
    
end

