function [ maxprof ] = getmaxprof( size, index1, index2 )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    maxprof=[0 0];
    if index1>size-index1; maxprof(1)=index1; else maxprof(1)=size-index1; end
    if index2>size-index2; maxprof(2)=index2; else maxprof(2)=size-index2; end
    maxprof=max(max(maxprof))+2;
end