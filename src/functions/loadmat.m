function [ latitude, longitude, elevation ] = loadmat( pathname, filename)
%LOADMAT Returns the X, Y and Z data from a .mat formatted file.
%   [latitude, longitude, elevation] = LOADMAT(pathaname,filename) returns 
%   the latitude, longitude and elevation data from a file called 
%   'filename' of .mat format in the path 'pathname'.
%
%           .mat    -> Variables must be labelled as X,Y,Z

% Load data to variables
    %MATLAB Workspace
    % NEED TO CHANGE FORMAT TO storedstructure.X ...Y ...Z AFTER TESTING IS
    % COMPLETED
    storedstructure=load([pathname filename]);
    latitude=storedstructure.latitudedef;
    longitude=storedstructure.longitudedef;
    elevation=storedstructure.elevation;
end

