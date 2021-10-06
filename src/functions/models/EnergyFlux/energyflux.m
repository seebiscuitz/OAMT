function TL = energyflux(F,cw,cb,rho,alpha_b,H,H0,Hmin,H_int,r,WindSpeed)
    % Energy flux model by D. E. Weston is used for TL prediction with
    % bathymetry map.
    
    % Based on various codes including
    % anomaly.m by Henry Dol, 22 February 2009 and 
    % Energy_Flux_TL by L. Wang, 28 April, 2011
    %
    % Code has been streamlined, vectorised and generally
    % optimised for iterative use by M. Wood August 2011
    %
    %Usage
    %  TL = weston(F,WindSpeed,cw,cb,rho,alpha_b,H,H0,r,Hmin3,H_int,Hmin)
    %Where:
    %  TL is the resulting transmission loss at all 
    %    receiver points and frequencies             (dB)        [nxmxk]
    %  F is a frequency vector                       (Hz)        [kx1]
    %  cw is the sound speed in water                (m/s)       [1x1]
    %  cb is the soundspeed in the sediment          (m/s)       [1x1]
    %  rho is the Ratio of density (sediment/water)  (   )       [1x1]
    %  alpha_b is the attenuation in dB/lambda       (dB/lambda) [1x1]
    %  H is the original depth data                  (m)         [nxm]
    %  H0 is the depth at the source                 (m)         [1x1]
    %  Hmin is the minimum depth between the source
    %    and receiver in each location               (m)         [nxm]
    %  H_int is the integrated depth between the 
    %    source and receiver in each location        (m^2)       [nxm]
    %  r is the distance between the source and each
    %    receiver (r = -1 where on land)             (m)         [nxm]
    %  WindSpeed is the windspeed...                 (m/s)       [1x1]

    % Initialisation of model constants
    log10e  = log10(exp(1));
    sqrt2   = sqrt(2);
    thetac  = acos(cw/cb);             % Critical angle of reflection
    thetac2 = thetac^2;
    c1      = 7.6e-4;
    c2      = 1/(10*pi*log10e);
    bb      = c2*rho*alpha_b/thetac^3; % Bottom reflection loss
    
    %Height map constants
    Hmin3 = Hmin.^3;

    % Propagation boundaries
    r1 = H0/sqrt2;
    r2 = H0/thetac/2;

    % Initialise TL 
    TL = zeros(size(r,1),size(r,2),length(F));
    

    for FreqInd = 1:length(F); % Loop over frequency
        
        Fm      = F(FreqInd);                   % Frequency in Hz
        lambda  = cw/Fm;                        % Wavelength
        lambda2 = lambda^2;                     % Wavelength (squared)
        k1      = 2*pi/lambda;                  % Wavenumber
        k2      = k1^2;                         % Wavenumber (squared)
        kFm     = Fm/1000;                      % Frequency in kHz
        alpha_w = alpha_Thorp(kFm)/1000;        % Attenuation in dB/m
        bs      = c1*kFm^1.5*WindSpeed^4;       % Surface reflection loss
        btot    = bs + bb;                      % Total reflection loss
        r3      = 2*pi*H0/(btot*thetac2);       % Propagation boundary
        r4      = 27*k2*Hmin3/btot/(2*pi).^2;	% Propagation boundary
        H_intrt = sqrt(btot*H_int);             % Used in Mode-stripping region
        
        %force r4 to be greater than r3
        r2 = r2.*(r2 > r1) + r1.*(r2 <= r1);
        r3 = r3.*(r3 > r2) + r2.*(r3 <= r2);
        r4 = r4.*(r4 > r3) + r3.*(r4 <= r3);
        
        % Initialise propagation loss
            PL = 0*H;
            PL(r > -0.1) = -10*log10(4) + 20*log10(H0);
            RL = zeros(size(r,1),size(r,2));
       
        %The faster version
        %Calculate the four regimes of propagation loss
        %using 2-dimensional vectorisation along with logical test built-in
        %instead of repeated ifs
        
        %Initialise constants
            rHH0 = abs(r).*H*H0;
        %Avoid 'log10 of zero's
            H_intrtC = H_intrt .* (H_intrt>0) + eps .* (H_intrt<=0);
            HminC = Hmin .* (Hmin>0) + eps .* (Hmin<=0);
        
        % Propagation in very nearby region (spherical spreading)
            PL1 = (20*log10(abs(r))) ...
                    .* (r > r1 & r <= r2);
        % Propagation in nearby region (cylindrical spreading)    
            PL2a = (10*log10(rHH0./(2*HminC*thetac)))...
                    * (H0*sin(thetac) >= lambda/4) ...
                    .* ((r > r2) & (r <= r3));
            % Cut-off duct at source
            PL2b = 200 ... 
                    * (H0*sin(thetac) < lambda/4) ...
                    .* (r > r2 & r <= r3);
        % Propagation in distant region (mode stripping)
            PL3 = (10*log10(rHH0.*H_intrtC/5.22)) ...
                    .* (r > r3 & r <= r4);
        % Fast decaying propagation in very distant region (single mode)
            PL4 = (10*log10(rHH0/lambda)+lambda2*btot*H_int/8) ...
                    .* (r > r4);
        %Total propagation loss
            PL = (PL1 + PL2a + PL2b + PL3 + PL4) .* (r>-0.1) + ...
                    PL .* (r<=-0.1);
                
        % Additional loss due to absorption
            RL(r > -0.5) = RL(r > -0.5) - 20*log10e*alpha_w*r(r > -0.5);
        % Transmission loss for this frequency is
            TL(:,:,FreqInd) = PL - RL;
        % Mark out areas that are interfered by land
%             TL(r < -0.5) = NaN;    
        TL(r < -0.5) = inf;
    end % Loop over frequency
end   