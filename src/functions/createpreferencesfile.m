function [  ] = createpreferencesfile( settings, filepath )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% need to update summary
% need to edit so class is passed to function
% function then writes to file rom class
    fid = fopen( [filepath '/settings.txt'], 'wt' );
    addpath(filepath);
    fprintf(fid,['scalefactor=' num2str(settings.scalefactor) '\n']);
    fprintf(fid,['interpmethod=' settings.interpmethod '\n']);
    fprintf(fid,['defaultsessionprefix=' settings.defaultsessionprefix '\n']);
    fprintf(fid,['propagationmodel=' settings.propagationmodel '\n']);
    fclose(fid);
end

