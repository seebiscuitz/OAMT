function [  ] = createlogsource(filepath, session_name, sourcearray)
%CREATELOG Creates a log file for current session
%   Creates a log file of current session in .dat format.

    mkdir([filepath '/data/sources']);
    fid=fopen([filepath '/' session_name '.dat'],'a');
    fprintf(fid,'%s','Created sources : ');
    fclose(fid);
    % append to log file
    for i=1:length(sourcearray)
        fid=fopen([filepath '/data/sources/' sourcearray(i).sourcelabel '.dat'],'w');
        fprintf(fid,['sourcelabel=' sourcearray(i).sourcelabel ' \r\n'],'string');
        fprintf(fid,['latitude=' sourcearray(i).latitude ' \r\n'],'string');
        fprintf(fid,['longitude=' sourcearray(i).longitude ' \r\n'],'string');
        fprintf(fid,['frequencyvector=' sourcearray(i).frequencyvector ' \r\n'],'string');
        fprintf(fid,['depth=' sourcearray(i).depth ' \r\n'],'string');
        fclose(fid);    
        fid=fopen([filepath '/' session_name '.dat'],'a');
        fprintf(fid,'%s','Created sources : ');
        fprintf(fid,['Name: ' sourcearray(i).sourcelabel ' \r\n'],'string');
        fprintf(fid,['Lat: ' sourcearray(i).latitude],'string');
        fprintf(fid,['Lon: ' sourcearray(i).longitude],'string');
        fprintf(fid,['Depth: ' sourcearray(i).depth ' \r\n'],'string');
        fprintf(fid,['Freq: ' sourcearray(i).frequencyvector  ' \r\n'],'string');        
        fclose(fid);   
    end
    
end