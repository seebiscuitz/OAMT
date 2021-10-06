function [ output_args ] = initialstartup( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    if isempty(strfind(path,'/home/sharefiles;'))
        addpath('/home/sharefiles')
    end 

end

