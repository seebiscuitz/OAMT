function [ latitude, longitude, elevation ] = loadnc( pathname, filename)
%LOADNC Returns the X, Y and Z data from a nc formated file
%   [latitude, longitude, elevation] = LOADNC(pathaname, filename) returns 
%   the latitude, longitude and elevation data from a .nc called 'filename'
%   in the path 'pathname'.
%
%           .nc     -> NC File: Variables X, Y and Z have sizes [n], [m] 
%                   and [nxm] respectively. Ususal format of GEBCO data.
%                   Variables must be named lat, lon and elevation or
%                   latitude, longitude and elevation.

%NC Format
    latitude=ncread([pathname filename],'lat');
    longitude=ncread([pathname filename],'lon');
    elevation=ncread([pathname filename],'elevation');            

end

