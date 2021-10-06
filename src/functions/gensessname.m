function [ sessname, ses_started ] = gensessname( defprefix )
%GENSESSNAME Creates session name from prefix and current time using
%'clock' function. Also returns when the session was started as a string.
%   Detailed explanation goes here
    format shortg;
    a=clock;
    sessname=[defprefix sprintf('%02d%02d%02d%02d', a(2), a(3), a(4), a(5))];
    ses_started=sprintf('%02d:%02d:%02d', a(4), a(5), round(a(6)));
end

