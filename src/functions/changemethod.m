function [ griddata_method ] = changemethod( interp2_method )
%CHANGEMTHOD Changes method from interp2 type to griddata type.
%   Detailed explanation goes here
    switch interp2_method
        case 'spline'
            griddata_method='v4';
        otherwise
            griddata_method=interp2_method;
    end
end