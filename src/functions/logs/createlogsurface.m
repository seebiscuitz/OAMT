function [  ] = createlogsurface(filepath, session_name, surfaceobject)
%CREATELOG Creates a log file for current session
%   Creates a log file of current session in .dat format.


    datasizes=[size(surfaceobject.XData);size(surfaceobject.YData);size(surfaceobject.ZData);];
    % append to log file
    fid=fopen([filepath '\' session_name '.dat'],'a');
    fprintf(fid,'%s','Created surface with data sizes: ');
    fprintf(fid,['Xdata: %s' num2str(datasizes(1,1)) 'x%s' num2str(datasizes(1,2))],'string');
    fprintf(fid,['\r\n Ydata: %s' num2str(datasizes(2,1)) 'x%s' num2str(datasizes(2,2))],'string');
    fprintf(fid,['\r\n Zdata: %s' num2str(datasizes(3,1)) 'x%s' num2str(datasizes(3,2))],'string');
    fclose(fid);
    mkdir([filepath '\data\']);
     try
         save([filepath '\data\surfobj.mat'],'surfaceobject');
     catch
     end
end