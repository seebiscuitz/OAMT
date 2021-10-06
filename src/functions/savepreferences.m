function [  ] = savepreferences( globalpreferences )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    fid = fopen( 'settings.txt', 'wt' );
    fprintf(fid,'scalefactor=50\n');
    fprintf(fid,'interpmethod=linear\n');
    fprintf(fid,'defaultsessionprefix=session_\n');
    fclose(fid);

end

