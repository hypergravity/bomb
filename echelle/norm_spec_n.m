function [ynorm,continuum] = norm_spec_n(x,y,wavestart,waveend,smoothness,s2,q,delta_lambda)
% s3=1;
q2=0.5;
%%
% normalize the spectrum, 
% x: wavelength%y: spectrum
% Example:
%     [ynorm,continuum]=normSpectrum(x,y,wavestart,waveend,1e-8,1e-7,0.7);

if isrow(x)
    x = x';end
if isrow(y)
    y = y';end


%##########################################################################
%initial guess of the continuum
f=csaps(x,y,smoothness); 
y1=fnval(f,x);
%the residual of the continuum
dy=y-y1;
%in this wavelength bins
wcent=wavestart:delta_lambda:waveend;
% delta_lambda=100;
%calculate the quantile-q value  for each bin and select the data within
%0.1sigma around the q-quantile to determine the new iterated continuum.
indgood=zeros(length(x),1);
for i=1:length(wcent)
    indw=(x>=(wcent(i)-delta_lambda) & x<(wcent(i)+delta_lambda));    
    sd=median(abs(dy(indw)-median(dy(indw))));  %sigma  
    indgood=indgood | (abs(dy-quantile(dy(indw),q))<(1*sd)).*indw;
    % collecting continuum pixels in each region
end


%##########################################################################
f2=csaps(x(indgood),y(indgood),s2); 
y2=fnval(f2,x);
%get the normalized data
% ynorm=y./y2;
% continuum=y2;

%ITERATE-2
dy=y-y2;
wcent=wavestart:delta_lambda:waveend;
delta_lambda=delta_lambda/2;
%calculate the quantile-q value  for each bin and select the data within
%0.1sigma around the q-quantile to determine the new iterated continuum.
indgood=zeros(length(x),1);
for i=1:length(wcent)
    indw=(x>=(wcent(i)-delta_lambda) & x<(wcent(i)+delta_lambda));    
    sd=median(abs(dy(indw)-median(dy(indw))));    
    indgood=indgood | ((dy-quantile(dy(indw),q2))<(3*sd)).*indw;
end


%##########################################################################
% f2=csaps(x(indgood),y2(indgood),s3); 
% y3=fnval(f2,x);

ynorm = y./y2; % norm flux
continuum = y2;% continuum

% the normalized spectrum may bias a little bit up the true value due to
% the usage of the q-quantile. This can be corrected by adding a mean offset
% between the current normalized spectrum and the probably true value
% ind=x>=wavestart & x<=waveend;
% dcont=(continuum-y)./continuum;
% 
% md=median(dcont(ind));
% ynorm=ynorm+md;
% continuum=continuum+md;