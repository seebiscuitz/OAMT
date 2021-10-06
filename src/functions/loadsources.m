function [ sourcearray ] = loadsources( filepath )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    %search for source files
    %waithandle=waitbar(0,'Loading source X/X','Name','Loading sources from file');
    sourcefiles=dir(fullfile(filepath,'/data/sources/*.dat'));
    sourcearray=repmat(sourceclass,length(sourcefiles),1);
    for j=1:length(sourcefiles)
        %waitbar(j/length(sourcefiles),waithandle,sprintf('Loading source: %d/%d',num2str(j),num2str(length(sourcefiles))));
        fileID=fopen([filepath '/data/sources/' sourcefiles(j).name],'rt');
        inputfile=textscan(fileID,'%s');
        inputfile=inputfile{1};
        sourcearray(j)=sourceclass;
        % set preferences
        for i=1:length(inputfile)
            currsource = inputfile{i};
            indx = strfind(currsource,'=');
            currsourcename = currsource(1:indx-1);
            currsourceval = currsource(indx+1:end);
            try
                sourcearray(j).(currsourcename)=currsourceval;
                lastsourcename=currsourcename;
            catch
               if strcmp(lastsourcename,'frequencyvector');
                   sourcearray(j).frequencyvector=[sourcearray(j).frequencyvector ' ' currsource];
               end
               if strcmp(lastsourcename,'sourcelevel');
                   sourcearray(j).sourcelevel=[sourcearray(j).sourcelevel ' ' currsource];
               end
            end
        end 
        %close file
        fclose(fileID);
    end
    %delete(waithandle);
end

