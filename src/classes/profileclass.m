classdef profileclass
    properties
        proflabel;
        transloss;
        etime;
    end
    methods
        function obj=profileclass(proflabel,transloss,etime)
            if nargin>0
                obj.proflabel=proflabel;
                obj.transloss=transloss;
                obj.etime=etime;
            end
        end
    end
end