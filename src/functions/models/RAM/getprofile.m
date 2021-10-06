function [ profile, rng ] = getprofile( H, idx, idy, c1, c2, rspace, cspace)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
            rdiff=c1-idy;
            cdiff=c2-idx;
            if rdiff==0;
                % - same row -
                %dint=zeros(abs(cdiff));
                if sign(cdiff)==1; dint=H(idy,idx:c2); 
                else dint=H(idy,c2:idx); end
                rng=cdiff*cspace;
                % - end -
            elseif cdiff==0
                % - same column -
                %dint=zeros(abs(rdiff));
                if sign(rdiff)==1; dint=H(idy:c1,idx); 
                else dint=H(c1:idy,idx); end
                rng=rdiff*rspace;
                % - end -                
            elseif abs(cdiff)==abs(rdiff)
                % - diagonal -
                dint=zeros(abs(cdiff)-1,1);
                if sign(cdiff)==-1; cinc=-1; else cinc=1; end
                if sign(rdiff)==-1; rinc=-1; else rinc=1; end
                if sign(cinc)==1; if sign(rinc)==1; mdf=1; else mdf=-1; end
                else if sign(rinc)==1; mdf=-1; else mdf=1; end; end
                for k=cinc:cinc:cdiff+(-1*cinc)
                    dint(abs(k))=H(idy+(k*mdf)+(1*rinc),idx+(k));
                end
                if abs(cdiff)==1; dint=[H(idy,idx);H(idy+rinc,idx+cinc)]; end
                rng=sqrt((cdiff*cspace)^2+(rdiff*rspace)^2);
                % - end -
            else
                % - otherwise -
                theta=atand((abs(rdiff)*rspace)/(abs(cdiff)*cspace));
                if sign(cdiff)==-1; cinc=-1; else cinc=1; end
                if sign(rdiff)==-1; rinc=-1; else rinc=1; end
                if abs(rdiff)>abs(cdiff)
                    dint=zeros(abs(rdiff),1);
                    if sign(rdiff)==1; if sign(cinc)==1; mdf=1; else mdf=-1; end
                    else if sign(cinc)==1; mdf=-1; else mdf=1; end; end
                    theta=90-theta;
                    for k=rinc:rinc:rdiff+(-1*rinc)
                        opp=k*rspace*tand(theta)*mdf;
                        count=fix(opp/cspace);
                        opp=rem(opp,cspace);
                        opp=opp*(abs(opp)>(cspace*0.001));
                        if opp==0
                           dint(abs(k))=H(idy+k,idx+count+(1*rinc));
                        else
                            m=H(idy+k,idx+count+(-1*rinc))-H(idy+k,idx+count);
                            x=abs(opp/cspace);
                            dint(abs(k))=(m*x)+H(idy+(k),idx+count);
                        end
                    end
                    rng=sqrt((cdiff*cspace)^2+(rdiff*rspace)^2);
                    %dint(end)=H(c1,c2);
                else
                    dint=zeros(abs(cdiff),1);
                    if sign(cdiff)==1; if sign(rinc)==1; mdf=1; else mdf=-1; end
                    else if sign(rinc)==1; mdf=-1; else mdf=1; end; end
                    for k=cinc:cinc:cdiff+(-1*cinc)
                        opp=k*cspace*tand(theta)*mdf;
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
                    rng=sqrt((cdiff*cspace)^2+(rdiff*rspace)^2);
                    %dint(end)=H(c1,c2);
                end
                % - end -
            end
            sd=size(dint);
            if sd(1)==1; dint=dint'; end
            profile=[H(idy,idx);dint];  
end

