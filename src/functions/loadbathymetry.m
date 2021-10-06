function [ latitude, longitude, elevation ] = loadbathymetry( pathname, filename, filetype )
%LOADBATHYMETRY Returns the X, Y and Z data from a supported data type
%file.
%   [latitude, longitude, elevation] = LOADBATYMETRY(pathaname,  ...
%   filename, filetpye) returns the latitude, longitude and elevation data 
%   from a file called 'filename' of supported file types in the path 
%   'pathname'.
%
%   Suported filetypes include;
%           .nc     -> NC File: Variables X, Y and Z have sizes [n], [m] 
%                   and [nxm] respectively. Ususal format of GEBCO data.
%                   Variables must be named lat, lon and elevation or
%                   latitude, longitude and elevation.
%           .csv    -> CSV: Variables X, Y and Z all have size [n]. Data
%                   can have headers in columns.
%           .mat    -> Variables must be labelled as X,Y,Z and have

% Load data to variables
    switch filetype
        case '.nc'
            %NC Format
            latitude=ncread([pathname filename],'lat');
            longitude=ncread([pathname filename],'lon');
            elevation=ncread([pathname filename],'elevation');            
        case '.csv'
            %CSV Format
            %Check for headers
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
        case '.mat'
            %MATLAB Workspace
            storedstructure=load([pathname filename]);
            latitude=storedstructure.latitudedef;
            longitude=storedstructure.longitudedef;
            elevation=storedstructure.elevation;
        otherwise
            %Non-supported file types
            latitude = NaN;
            longitude = NaN;
            elevation = NaN;
    end
end

