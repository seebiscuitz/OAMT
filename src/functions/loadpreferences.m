function [ settingsout ] = loadpreferences( filename )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    %open file
    fileID=fopen(filename,'rt');
    inputfile=textscan(fileID,'%s');
    inputfile=inputfile{1};
    settingsout=settingsclass;
    % set preferences
    for i=1:length(inputfile)
        currsetting = inputfile{i};
        indx = strfind(currsetting,'=');
        currsettingname = currsetting(1:indx-1);
        currsettingval = currsetting(indx+1:end);
        try
            settingsout.(currsettingname)=currsettingval;
%             disp(settingsout.(currsettingname))
        catch
           %do nothing 
        end
    end 
    %close file
    fclose(fileID);
end

