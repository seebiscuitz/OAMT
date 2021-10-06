function [ varargout ] = vectortosquare( varargin )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    nout=max(nargout,1);
    %varargout{i}=output;
    for i=1:nout
        fid=fopen(varargin{i});
        A=fread(fid);
        fclose(fid);
        sqrA=sqrt(numel(A));
        varargout{i}=reshape(A,sqrA,sqrA); 
    end
end

