function [cartgrid] = calccartgrid(TL,SrcLat,SrcLon,bearingmatrix)
%CALCCARTGRID Calculates cartesian grid from profile
    %~woooo spoookkky ghossssstt~
    totalpofilelength=0;
    for i=1:length(TL.profile)
       totalpofilelength=totalpofilelength+length(TL.profile(i).profrange); 
    end
    cartmatrix=NaN.*zeros(totalpofilelength,3);
    k=1;
    count=1;
    for i=1:length(TL.profile)
        TLprof=TL.profile(i);
        theta=bearingmatrix(i);
        for j=1:length(TLprof.profrange)
           xcord=SrcLat+(j*(100/(6378*10^3)));
           ycord=SrcLon+(j*(100/(6378*10^3))*(180/pi)/cos(SrcLat*pi/180));
           tl=TLprof.tlvector(j,k);
           cartmatrix(count,1:3)=[xcord,ycord,tl];
           count=count+1;
        end
    end
    cartgrid=sortrows(cartmatrix,[1,2]);
end