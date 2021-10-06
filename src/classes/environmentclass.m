classdef environmentclass
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        dz = 100;  % depth step size
        dr = 100;  % range step size
        cw = 1500;  % speed in water
        cs;  % speed in sediment
        rho; % density
        attn;% attenuation
        ws = 0; % windspeed
    end
    
    methods
        function obj=environmentclass(dz,dr,cw,cs,rho,attn,ws)
            if nargin>0        
                obj.dz=dz;
                obj.dr=dr;
                obj.cw=cw;
                obj.cs=cs;
                obj.rho=rho;
                obj.attn=attn;
                obj.ws=ws;
            end
        end
    end
    
end

