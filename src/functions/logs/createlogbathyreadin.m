function [  ] = createlogbathyreadin(filepath, session_name, pathname, filename, filetype, datasizes)
%CREATELOGBATHYREADIN Creates a log file for current session
%   Creates a log file of current session in .dat format.
    
    % append to log file
    fid=fopen([filepath '/' session_name '.dat'],'a');
    fprintf(fid,['Loaded bathymetry data from ' filename '\r\n'],'string');
    fprintf(fid,'%s',['Fullpath: ' pathname]);
    fprintf(fid,['\r\n Data loaded from ' filetype ' format with sizes:\r\n'],'string');
    fprintf(fid,['Latitude: ' num2str(datasizes(1,1)) 'x' num2str(datasizes(1,2)) '\r\n'],'string');
    fprintf(fid,['Longitude: ' num2str(datasizes(2,1)) 'x' num2str(datasizes(2,2)) '\r\n'],'string');
    fprintf(fid,['Elevation: ' num2str(datasizes(3,1)) 'x' num2str(datasizes(3,2)) '\r\n'],'string');
    fclose(fid);
    % append to resume.dat
    fid=fopen([filepath '/resume.dat'],'a');
    fprintf(fid,'%s',['bfile=' pathname filename ]);
    fprintf(fid,'%s','\r\n');
    fclose(fid);
end

