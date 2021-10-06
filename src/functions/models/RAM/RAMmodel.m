function [ramsrcarray, coordsmatrix] = RAMmodel(surfobject, sourcearray, envclass, profmatrix)
% RAMMODEL Generates TL grid using the Range-dependent Acoustic Model
    % Detailed explanation goes here
    global definedenv
    ramwaitbar=waitbar(0,'Calculating RAM','Name','');
    ramsrcarray(1:length(sourcearray))=ramarrayclass;
    for i=1:length(sourcearray)
        waitbar(0,ramwaitbar,'Preparing profiles','Name',sprintf('Calculating TL for source %d/%d',i,length(sourcearray)));
        % - 2D profile generation -
        Lat=surfobject.XData(1,:);
        Lon=surfobject.YData(:,1);
        H=surfobject.ZData;
        if exist('definedenv')==1;
            if length(definedenv)==length(sourcearray)
                if ~isempty(definedenv(i).coords)
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
        if isempty(profmatrix(i).coords)
            [profM, rngM, coordsmatrix]=RAMprofile(H,sourcearray(i),Lat,Lon);
        else
            % - create profiles -
            mxlength=getmaxprof(max(size(H)),idx,idy);
            profM=zeros(length(profmatrix(i).coords),mxlength);
            rngM=zeros(length(profmatrix(i).coords),1);
            for j=1:length(profmatrix(i))
               prof=getprofilecust(H,idx,idy,profmatrix(i).coords(j,1),profmatrix(i).coords(j,2),Lat,Lon);
               profM(j,:)=[-1.*prof;NaN.*ones(mxlength-length(prof),1)];
               rngM(j,1)=vdist(str2double(signalsources(i).latitude),str2double(signalsources(i).longitude),profmatrix(i).coords(j,1),profmatrix(i).coords(j,2));
            end
            % - end -
        end
        % - end -
        freqz=str2double(strsplit(sourcearray(i).frequencyvector,' '));    % source frequency vector
        for j=1:round(length(profM)) %loop for each profile in array
            proftic=tic;
            waitbar(j,ramwaitbar,sprintf('Calculating TL for profile %d/%d',j,length(profM)));
            % - profile fixing -
            depthprofile=profM(j,:);
            depthprofile(depthprofile<0)=[];
            depthprofile(isnan(depthprofile))=[];
            % - end -
            dz=str2double(envclass.dz);                                    % depth step size
            dr=str2double(envclass.dr);                                   % range step size
            % - Environment Variables -
            rmax=rngM(j);                               % max range
            rslice=length(depthprofile)*10;             % number of range slices
            rg=rmax/rslice:rmax/rslice:rmax;            % vector of output ranges
            rb=rngM(j)/length(depthprofile):rngM(j)/length(depthprofile):max(rg);% bathymetry range
            cw=str2double(envclass.cw);                                    % speed in water
            c0=mean(cw(:));                             % avg speed in water
            cs=str2double(envclass.cs);                                    % speed in sediment
            zr=[max(depthprofile) max(depthprofile)+1]; % density depth
            rho=str2double(envclass.rho);                                   % density
            attn=str2double(strsplit(envclass.attn,' '));                           % attenuation
            nrp=1;
            attn=ones(nrp,1)*attn;                      % attenuation
            zmax=(4*max(depthprofile))/3;                     % max depth
            % - end -
            % - RAM variables -
            dim=2;                                      % self starter
            zw=0:1:5000;                               % sound speed
            zw=zw(:);                                   
            rp=0;                                       % range of profiles                             
            zs=zw;                                      % sediment speed grid depth
            zbm=max(depthprofile);                               
            za=[zbm+1 zbm+2];                       % attenuation depth grid
            np=6;                                       % pade coefficients
            ns=1;                                       % no. stability terms
            rs=10000.0;                                 % stability range
            dzm=1;                                      % output decimation
            % - end -
            % - source variables -
            zsrc=str2double(sourcearray(i).depth)   ;                  % source depth
            % - end -
            for k=1:length(freqz)
                    freqtic=tic;
                    [psi, zg, rout]=ram( freqz(k),zsrc,dim,rg,dr,zmax,dz,dzm,...
                           c0,np,ns,rs,rb,depthprofile,rp,zw,cw,zs,cs,zr,rho,za,attn);
                       tl=bsxfun(@plus,-20*log10(abs(psi)+1e-20),10*log10(rout+1e-20));
                    % - TL extension -
                    freqtoc=toc(freqtic);
                    translossclass(k)=transmissionlossclass(freqz(k),tl,rg,zg,freqtoc);
            end
            proftoc=toc(proftic);
            RAMArray(j)=profileclass(num2str(j),translossclass,proftoc);
        end
        ramsrcarray(i).sourcelabel=sourcearray(i).sourcelabel;
        ramsrcarray(i).profile=RAMArray;
        clear RAMArray
    end
    delete(ramwaitbar)
    save('TL.mat','ramsrcarray');
end