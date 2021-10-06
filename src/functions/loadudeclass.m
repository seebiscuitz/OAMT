function [ udeclass ] = loadudeclass( filepath )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    %search for source files
    udefiles=dir(fullfile(filepath,'data\*_env.dat'));
    udeclass=repmat(userdeclass,length(udefiles),1);
    for j=1:length(udeclass)
        fileID=fopen([filepath 'data\' udefiles(j).name],'rt');
        inputfile=textscan(fileID,'%s');
        envparams = inputfile;
        envparams = envparams{1};
        for i=1:length(envparams)
            currparam=envparams{i};
            indx = strfind(currparam,'=');
            udeparam = currparam(1:indx-1);
            paramval = currparam(indx+1:end);
            try
                udeclass(j).(udeparam)=paramval;
                lastvarname=udeparam;
            catch
               if strcmp(lastvarname,'coords');
                   udeclass(j).coords=[udeclass(j).coords ' ' currparam];
               end
            end
        end 
        fclose(fileID);
    end
end

