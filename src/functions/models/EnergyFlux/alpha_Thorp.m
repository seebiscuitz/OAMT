function A = alpha_Thorp(f)
% function alpha_Thorp(f)
% absorption/attenuation formula from Thorp
% f = frequency(kHz)
% output in dB/km 

% creation date: 20.11.03, MAA

% modification history
% change number DATE    author  description
% 001           28.03.07    MAA corrected A3 term (missing conversion to
% SI)
  

% Boron relaxation frequency
F1 = 1.0;

% Magnesium relaxation frequency
F2 = 4100^0.5;

A1 = 0.1/0.9144*((f.^2)./(f.^2+F1.^2));

A2 = (40/0.9144)*((f.^2)./(f.^2+F2.^2));

A3 = 2.75e-4* f.^2;
A3=A3/0.9144; %CHANGE 001

A = A1+A2+A3;
