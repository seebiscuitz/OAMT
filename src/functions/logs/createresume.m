function [  ] = createresume(session_name, filepath)
%CREATELOG Creates a log file for current session
%   Creates a log file of current session in .dat format.
    fid=fopen([filepath '/' 'resume.dat'],'a');
    fprintf(fid,['sessionname=' session_name '\r\n'],'string');
    fclose(fid);
end