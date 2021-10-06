function [x, fx]=ridder( fhdl, xl, xh, xrhs, xacc, varargin)
%function [x, fx]=ridder( fhdl, xl, xh, xrhs, xacc, varargin);
% 
% solves f(x)=xrhs
% 

fl=feval( fhdl, xl, varargin{:})-xrhs;
fh=feval( fhdl, xh, varargin{:})-xrhs;

if any(fl.*fh>0)
  error('root must be bracketed');
end

x=(xl+xh)/2;
fx=feval( fhdl, x, varargin{:})-xrhs;

while 1
  xm=(xl+xh)/2;
  fm=feval( fhdl, xm, varargin{:})-xrhs;
  dnm=sqrt( fm.*fm - fl.*fh);
  if any(dnm==0) return; end
  xnew=xm+(xm-xl).*sign(fl-fh).*fm./dnm;

  if all( abs(xnew-x)<=xacc) return; end
  
  x=xnew;
  fnew=feval( fhdl, x, varargin{:})-xrhs;
  fx=fnew;
  if all( fnew==0) return; end

  ind=find( fnew.*fm<0);
  xl(ind)=xm(ind); fl(ind)=fm(ind);
  xh(ind)=xnew(ind); fh(ind)=fnew(ind);

  ind=find( fnew.*fh<0);
  xl(ind)=xnew(ind); fl(ind)=fnew(ind);

  ind=find( fnew.*fl<0);
  xh(ind)=xnew(ind); fh(ind)=fnew(ind);

  if all( abs(xh-xl)<=xacc) return; end
end


return

