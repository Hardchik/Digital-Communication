function [xq]=Alawquan(t,y,L,A) 
%Following code is meant to perform mu law quantization on 1-D signal
% Author: M.Asif Khan mak4086@gmail.com
% Created on 5th August 2014

%Call this function with parameters t,y,L and mu
% y:signal
% t:sampling duration
% L:number of quantization Level
% xq: quantized signal
% mu:parameter for quantization 
% To run the code execute following on command window:
% 
% Fs=60000;Ts=1/Fs;f=3000;n=0:Ts:(4/f);y=sin(2*pi*f*n);
% L=4,A=1
% [xq]=Alawquan(n,y,L,A)
%  
%read in input signal
xmin=-1;xmax=1;Q=(xmax-xmin)/2.^L;disp('R,xmin,xmax,N,Q,A');disp([L,xmin,xmax,2^L,Q,A]);
%apply A-law transform to original sample
[yy,~]=Alaw(y,A);
%apply uniform quantization on the absolute value each sample
[yq,~]=myquantizer(t,yy,L);
%apply inverse A-law transform to the quantized sequence %also use the original sign
[xq,~]=invAlaw(yq,A);
%plot waveforms over the entire period
figure; plot(t,y,'r:',t,xq,'b-');
axis tight; grid on;legend('original','quantized');
% Calculate the MSE
D=y-xq;
MSE=mean(D.^2);
fprintf('\n Error between original and quantized = %g\n\n',MSE )
end