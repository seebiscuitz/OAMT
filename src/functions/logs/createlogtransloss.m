function [ ] = createlogtransloss(filepath, session_name, sizetransloss, numsources)
%CREATELOGTRANSLOSS Creates a log file for current session
%   Creates a log file of current session in .dat format.
    
    % append to log file
    fid=fopen([filepath '/' session_name '.dat'],'a');
    fprintf(fid,['Created transmission loss data of size %d' sizetransloss(1)...
        'x%d' sizetransloss(2) 'x%d' sizetransloss(3)  ...
        'using EnergyFlux \r\n'],'string');
    fprintf(fid,['From %d' numsources ' sources \r\n'],'string');
    fclose(fid);
    % append to resume.dat
    fid=fopen([filepath '/resume.dat'],'a');
    fprintf(fid,'%s',['tfile=' filepath '/data/TL.mat \r\n']);
    fprintf(fid,'%s','\r\n');
    fclose(fid);

end

