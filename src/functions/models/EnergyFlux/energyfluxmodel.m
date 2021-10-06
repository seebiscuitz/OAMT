function [ TL ] = energyfluxmodel(surfobject, sourcearray)
%ENERGYFLUXMODEL Returns TL array of efluxarray class for environment
    global envclass
    global definedenv
    % - environment variables -
        cw=str2double(envclass.cw);            %  cw is the sound speed in water                (m/s)       [1x1]
        cb=str2double(envclass.cs);               %  cb is the soundspeed in the sediment          (m/s)       [1x1]
        rho=str2double(envclass.rho);              %  rho is the Ratio of density (sediment/water)  (   )       [1x1]
        alpha_b=str2double(envclass.attn);          %  alpha_b is the attenuation in dB/lambda       (dB/lambda) [1x1]
        %H(H>0)=0;
        WindSpeed=str2double(envclass.ws);        %  WindSpeed is the windspeed...                 (m/s)       [1x1]
    % - end -
    for i=1:length(sourcearray)
        H=surfobject.ZData; %  H is the original depth data                  (m)         [nxm]
        Lat=surfobject.XData(1,:);
        Lon=surfobject.YData(:,1);
        % - source variables -
        F=str2double(strsplit(sourcearray(i).frequencyvector));   %  F is a frequency vector                       (Hz)        [kx1]
        [~, idx]=min(abs(Lat-str2double(sourcearray(i).latitude)));
        [~, idy]=min(abs(Lon-str2double(sourcearray(i).longitude)));
        %H0=interp2(surfobject.XData,surfobject.YData,H,str2double(sourcearray(i).latitude),str2double(sourcearray(i).longitude));
        H0=H(idx,idy);                      %  H0, depth at the source                       (m)         [1x1]
        %  H_int is the integrated depth between the source and receiver in each location        (m^2)       [nxm]
        %  Hmin, min depth between source and receiver   (m)         [nxm]
        if exist('definedenv')==1;
            if length(definedenv)==length(sourcearray)
                if ~isempty(definedenv(i).coords)
                    if ischar(definedenv(i).coords);
                        strcoords=strsplit(definedenv(i).coords,' ');
                        strcoords=str2double(strcoords);
                        definedenv(i).coords=strcoords;
                    end
                    [~, indx1]=min(abs(Lat-(definedenv(i).coords(1))));
                    [~, indx2]=min(abs(Lat-(definedenv(i).coords(2))));
                    [~, indy1]=min(abs(Lon-(definedenv(i).coords(3))));
                    [~, indy2]=min(abs(Lon-(definedenv(i).coords(4))));
                    H=surfobject.ZData(min(indx1,indx2):max(indx1,indx2),min(indy1,indy2):max(indy1,indy2));
                    Lat=Lat(min(indx1,indx2):max(indx1,indx2));
                    Lon=Lon(min(indy1,indy2):max(indy1,indy2));
                end
            end
        end
        [H_int, Hmin]=intdepth3(-H,sourcearray(i),Lat,Lon);
        %  r is the distance between the source and each
        %    receiver (r = -1 where on land)             (m)         [nxm]
        r=receiverdistance(H,sourcearray(i),Lat,Lon,'negative');
        etime=0;
        for k=1:length(F)
            freqtic=tic;
            TL=energyflux(F(k),cw,cb,rho,alpha_b,-H,H0,Hmin,H_int,r,WindSpeed);
            freqtoc=toc(freqtic);
            translossclass(k)=transmissionlossclass(F(k),TL,H,0,freqtoc);
            etime=etime+freqtoc;
        end
        EFluxArray(i)=efluxarrayclass(sourcearray(i).sourcelabel,translossclass);       
    end
    TL=EFluxArray;
    %h = msgbox('Operation Completed');
end