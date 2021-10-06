function [ envclass ] = loadenvclass( filepath )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    %search for source files
    try
        fileID=fopen(filepath,'rt');
        inputfile=textscan(fileID,'%s');
        envparams = inputfile;
        envparams = envparams{1};
        for i=1:length(envparams)
            currparam=envparams{i};
            indx = strfind(currparam,'=');
            envparam = currparam(1:indx-1);
            paramval = currparam(indx+1:end);
            try
                envclass.(envparam)=paramval;
            catch
               do nothing 
            end
        end 
        %close file
        fclose(fileID);
    catch
        envclass=environmentclass;
    end
end

