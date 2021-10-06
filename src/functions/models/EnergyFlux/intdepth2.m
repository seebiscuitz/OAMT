function [ intH, Hmin, dintarray ] = intdepth2( H, source, lat, lon )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%     [~, idy]=min(abs(lat-str2double(source.latitude)));     % idy is source row
%     [~, idx]=min(abs(lon-str2double(source.longitude)));    % idx is source column
    [~, idy]=min(abs(lat-source.latitude));     % idy is source row
    [~, idx]=min(abs(lon-source.longitude));    % idx is source column
    %srzedpt=H(idy,idx);
    rspace=vdist(lat(1),lon(1),lat(1),lon(2));
    cspace=vdist(lat(1),lon(1),lat(2),lon(1));
    %theta=[];
    intH=zeros(length(H));
    Hmin=zeros(length(H));
    n=length(H);
    warning('off','all')
    dintarray=zeros(n,n,n);
    for i=1:n
        rdiff=i-idy;
        fprintf('\n%d',i)
        %tic
        for j=1:n
            cdiff=j-idx;
            if rdiff==0;
                % - same row -
                %dint=zeros(abs(cdiff));
                if sign(cdiff)==1; dint=H(idy,idx:j); 
                else dint=H(idy,j:idx); end
                spc=cspace:cspace:abs(cdiff*cspace);
                % - end -
            elseif cdiff==0
                % - same column -
                %dint=zeros(abs(rdiff));
                if sign(rdiff)==1; dint=H(idy:i,idx); 
                else dint=H(i:idy,idx); end
                spc=rspace:rspace:abs(rdiff*rspace);
                % - end -                
            elseif abs(cdiff)==abs(rdiff)
                % - diagonal -
                dint=zeros(abs(cdiff),1);
                if sign(cdiff)==-1; cinc=-1; else cinc=1; end
                if sign(rdiff)==-1; rinc=-1; else rinc=1; end
                if sign(cinc)==1; if sign(rinc)==1; mdf=1; else mdf=-1; end
                else if sign(rinc)==1; mdf=-1; else mdf=1; end; end
                for k=cinc:cinc:cdiff+(-1*cinc)
                    dint(abs(k))=H(idy+(k*mdf)+(1*rinc),idx+(k));
                end
                hyp=sqrt((cdiff*cspace)^2+(rdiff*rspace)^2);
                spc=hyp:hyp:(hyp*cdiff);
                % - end -
            else
                % - otherwise -
                theta=atand((abs(rdiff)*rspace)/(abs(cdiff)*cspace));
                if sign(cdiff)==-1; cinc=-1; else cinc=1; end
                if sign(rdiff)==-1; rinc=-1; else rinc=1; end
                if abs(rdiff)>abs(cdiff)
                    dint=zeros(abs(rdiff),1);
                    spc=zeros(abs(rdiff),1);
                    if sign(rdiff)==1; if sign(cinc)==1; mdf=1; else mdf=-1; end
                    else if sign(cinc)==1; mdf=-1; else mdf=1; end; end
                    theta=90-theta;
                    for k=rinc:rinc:rdiff+(-1*rinc)
                        opp=k*rspace*tand(theta)*mdf;
                        spc(abs(k))=sqrt(opp^2+(k*rspace)^2);
                        count=fix(opp/cspace);
                        opp=rem(opp,cspace);
                        opp=opp*(abs(opp)>(cspace*0.001));
                        %while abs(opp)>cspace; opp=opp-(cspace*cinc); count=count+(1*cinc); end
                        if opp==0
                           dint(abs(k))=H(idy+k,idx+count+(1*rinc));
                        else
                            m=H(idy+k,idx+count+(-1*rinc))-H(idy+k,idx+count);
                            x=abs(opp/cspace);
                            dint(abs(k))=(m*x)+H(idy+(k),idx+count);
                        end
                        %fprintf(' %d %d',count,k)
                    end
                    dint(end)=H(i,j);
                else
                    dint=zeros(abs(cdiff),1);
                    spc=zeros(abs(cdiff),1);
                    if sign(cdiff)==1; if sign(rinc)==1; mdf=1; else mdf=-1; end
                    else if sign(rinc)==1; mdf=-1; else mdf=1; end; end
                    for k=cinc:cinc:cdiff+(-1*cinc)
                        opp=k*cspace*tand(theta)*mdf;
                        spc(abs(k))=sqrt(opp^2+(k*cspace)^2);
                        count=fix(opp/rspace);
                        opp=rem(opp,rspace);
                        opp=opp*(abs(opp)>(rspace*0.001));
                        %while abs(opp)>rspace; opp=opp-(rspace*rinc); count=count+(1*rinc); end
                        if opp==0
                           dint(abs(k))=H(idy+count+(-1*cinc),idx+k);
                        else
                            m=H(idy+count+(1*cinc),idx+k)-H(idy+count,idx+k);
                            x=abs(opp/rspace);
                            dint(abs(k))=(m*x)+H(idy+count,idx+(k));
                        end
                        %fprintf(' %d %d',count,k)
                    end
                    dint(end)=H(i,j);
                end
                % - end -
            end
            try
                intH(i,j)=trapz(spc,dint);
            catch
                intH(i,j)=trapz(dint);
            end
            %try Hmin(i,j)=min(dint); catch; Hmin(i,j)=0; end
            Hmin(i,j)=min(dint);
            %clear dint
        end
        %tl=toc;
        %fprintf('   %.4f',tl)
    end
    warning('on','all')
end