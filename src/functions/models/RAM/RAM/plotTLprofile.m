function plotTLprofile(TLtransectNo, TLData, source, freq)
% PLOTTLPROFILE Plots TL graph from profile data selected by user in OAMT.
    %[][][][][][][][][][][][][][]
    % - plot data to new figure -
    h1=figure('Name','Transmission Loss vs Range and Depth');
    h=axes;
    pcolor(h,TLData.profrange,TLData.profdepth,TLData.tlvector);
    shading interp;
    %caxis([0 75]);
    colormap('default');
    Map = colormap;
    colormap(flipud(Map));
    h = colorbar;
    h2 = get(h, 'ylabel');
    set(h2, 'string', 'Transmission Loss (dB)');
    set(gca,'YDir','reverse')
    freqz=strsplit(source.frequencyvector);
    freq=freqz(freq);
    xlabel('Range (m)'), ylabel('Depth (m)'), title(sprintf('Transmission Loss (db) for %s No. %s @%sHz',source.sourcelabel,TLtransectNo,freq))
    % - end -
end