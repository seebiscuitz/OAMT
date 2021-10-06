function [ intH ] = intdepth( H, source, lat, lon )
%INTDEPTH Calculates the depth integral for every point in H from point
%source.
%   Detailed explanation goes here
     intH=zeros(size(H));
    H=surfaceobject.ZData;
    source=sourceclass;source.latitude='34';source.longitude='143';
    source.frequencyvector='1';source.depth='-2000';
    lat=surfaceobject.XData(1,:);lon=surfaceobject.YData(:,1);
    [~, idx]=min(abs(lat-str2double(source.latitude)));     % idx is source column
    [~, idy]=min(abs(lon-str2double(source.longitude)));    % idy is source row
    srzedpt=H(idy,idx);
    for i=1:length(H)                           % i is row counter.
        tic
        fprintf('\n%s ',num2str(i));
        for j=1:length(H)                       % j is column counter.
            if ~(i==idy && j==idx)
                if idy==i
                    % - same row -
                    A=zeros(j-idx,1);
                    A(1)=srzedpt;
%                     fprintf('%d ',j-idx)
                    if idx>j
                        temp1=-1;
                        scord=idx-1;
                    else
                        temp1=1;
                        scord=idx+1;
                    end
                    for x=scord:temp1:j;
                        A(abs(x-idx))=H(idy,x);
                    end
                    % - end -
                elseif idx==j
                    % - same column -
                    A=zeros(i-idy,1);
                    A(1)=srzedpt;                    
%                     fprintf('%d ',i-idy)
                    if idy>i
                        temp1=-1;
                        scord=idy-1;
                    else
                        temp1=1;
                        scord=idy+1;
                    end
                    for y=scord:temp1:i;
                        A(abs(y-idy))=H(y,idx);
                    end
                    % - end -
                else
                    % - not same row or column -
                    % calculate angle from vdist row diff and vdist col
                    % diff.
                    rowdiff=vdist(lat(idy),lon(idx),lat(idy),lon(i));
                    coldiff=vdist(lat(idy),lon(idx),lat(j),lon(idx));
                    theta=tan(rowdiff/coldiff);
                    % for each column/row difference
                    % 
                    if idy-i>idx-j
                        % - row difference -
%                         fprintf('  Row diff %s',num2str(j))
                        encord=i;
%                         fprintf('  %s steps',num2str((encord-1)-scord))
                        if idy>i
                            temp1=1;
                            scord=idy+1;
                        else
                            temp1=-1;
                            scord=idy-1;
                        end
                        A=zeros(abs(encord-scord),1);
                        A(1)=srzedpt;
%                         fprintf('%d ',encord-scord)
                        for x=scord:temp1:encord
                            % use angle and vdist and col/row step to calc
                            % opposite.
                            rdiff=vdist(lat(x),lon(idy),lat(x+1),lon(idy));
                            % calc ratio of opposite length to grid length
                            opp=rdiff*tan(90-theta);
                            % if greater than 1 then subtract one and move over 1
                            ratio=opp/rdiff;
                            if ratio>1
                                nopp=opp-rdiff;
                                rdiff=vdist(lat(x+1),lon(idy),lat(x+2),lon(idy));
                                ratio=nopp/rdiff;             
                                val=((H(idy,x+1)-H(idy,x+2))*ratio)+H(idy,x+1);
                            else  
                                val=((H(idy,x)-H(idy,x+1))*ratio)+H(idy,x);
                            end
                            % grid point and do new grid depth+(ratio*depth 
                            % difference)
                            % append to A matrix
                            % end for
                            A(abs(x-idy))=val;
                        end
                        % - end -
                    else
                        % - column difference -
%                         fprintf('  Col diff %s',num2str(j)')
                        encord=j;
%                         fprintf('  %s steps',num2str((encord-1)-scord))
                        if idx>j
                            temp1=-1;
                            scord=idx-1;
                        else
                            temp1=1;
                            scord=idx+1;
                        end
                        A=zeros(abs(encord-scord),1);
                        A(1)=srzedpt;
%                         fprintf('%d ',encord-scord)
                        for x=scord:temp1:encord;
                            % use angle and vdist and col/row step to calc
                            % opposite.
                            cdiff=vdist(lat(idy),lon(x),lat(idy),lon(x+1));
                            % calc ratio of opposite length to grid length
                            opp=cdiff*tan(theta);
                            % if greater than 1 then subtract one and move over 1
                            ratio=opp/cdiff;
                            if ratio>1
                                nopp=opp-cdiff;
                                cdiff=vdist(lat(idx),lon(x+1),lat(idx),lon(x+2));
                                ratio=nopp/cdiff;
                                val=((H(x+1,idx)-H(x+2,idx))*ratio)+H(x+1,idx);
                            else
                                val=((H(x,idx)-H(x+1,idx))*ratio)+H(x,idx);
                            end
                            % grid point and do new grid depth+(ratio*depth 
                            % difference)
                            % append to A matrix
                            % end for
                            A(abs(x-idx))=val;
                        end
                        % - end -
                    end
                    % - end -
                end
                intH(i,j)=trapz(A);
                clear A
            end
        end
        tl=toc;
        fprintf('%.2f',tl);
    end
end