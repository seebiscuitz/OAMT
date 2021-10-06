function [ resumeout ] = loadresume( filename )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    %open file
    fileID=fopen(filename,'r');
    inputfile=textscan(fileID,'%s');
    inputfile=inputfile{1};
    resumeout=resumeclass;
    % set preferences
    for i=1:length(inputfile)
        currresume = inputfile{i};
        indx = strfind(currresume,'=');
        ressettingname = currresume(1:indx-1);
        ressettingval = currresume(indx+1:end);
        try
            resumeout.(ressettingname)=ressettingval;
%             disp(settingsout.(currsettingname))
        catch
           %do nothing 
        end
    end 
    %close file
    fclose(fileID);
end

