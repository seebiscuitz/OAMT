function [ latitude, longitude, elevation ] = loadcsv( pathname, filename)
%LOADCSV Returns the X, Y and Z data from a csv formatted file.
%   [latitude, longitude, elevation] = LOADCSV(pathaname, filename) returns
%   the latitude, longitude and elevation data from a file called 
%   'filename' of .csv format in the path 'pathname'.
%
%           .csv    -> CSV: Variables X, Y and Z all have size [n]. Data
%                   can have headers in columns.

% Load data to variables
    data=csvread([pathname filename]);
    firstcell=data(1,1);
    if iscellstr(firstcell) 
        latitude=data(:,1);
        longitude=data(:,2);
        elevation=data(:,3);
    else
        latitude=data(1:end,1);
        longitude=data(1:end,2);
        elevation=data(1:end,3);
    end
end

