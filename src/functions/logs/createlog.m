function [  ] = createlog(session_name,session_started, filepath)
%CREATELOG Creates a log file for current session
%   Creates a log file of current session in .dat format.
    
%get username
    %[s,user]=dos('echo %USERNAME%');
    %user=getenv('USERNAME');
    %[s,comp]=dos('echo %COMPUTERNAME%');
    %comp=getenv('COMPUTERNAME');
    %session_started=session_name(end-7:end);
    session_time=sprintf('%d:%d',session_started(5:6), session_started(7:8));
    session_date=sprintf('%d/%d',session_started(3:4),session_started(1:2));
    user=char(java.lang.System.getProperty('user.name'));
    comp=char(java.net.InetAddress.getLocalHost.getHostName);
    fid=fopen([filepath '/' session_name '.dat'],'w+');
    fprintf(fid,[session_name ' started at ' session_time ' on ' session_date '\r\n'],'string');
    fprintf(fid,['By ' user ' on ' comp '\r\n'],'string');
    fclose(fid);
end

