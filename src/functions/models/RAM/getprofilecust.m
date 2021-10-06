function [ profile ] = getprofilecust( H, idx, idy, lat, lon, Lat, Lon)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    rspace=vdist(Lat(idx),Lon(idy),Lat(idx),lon);
    cspace=vdist(Lat(idx),Lon(idy),lat,Lon(idy));
    delX=Lat(idx)-lat;
    delY=Lon(idy)-lon;
    bearing=tand(delX/delY);
    for i=1:50
        % calcualte next lat lon point
        % find nearest points
        % interpolate to find depth value
        % add to profile
    end
end