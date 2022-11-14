function [xq]=mulawquan(t,y,L,mu) 
%Following code is meant to perform mu law quantization on 1-D signal
% Author: M.Asif Khan mak4086@gmail.com
%Call this function with parameters t,y,L and mu
% y:signal
% t:sampling duration
% L:number of quantization Level
% xq: quantized signal
% mu:parameter for quantization 
% To run the code execute following on command window:
% 
% Fs=60000;Ts=1/Fs;f=3000;n=0:Ts:(4/f);y=sin(2*pi*f*n);
% L=4;mu=0.56;
% [xq]=mulawquan(n,y,L,mu);
%  

%read in input signal
    xmin=min(y);
    xmax=max(y);
    Q=(xmax-xmin)/2.^L;
    disp('R,xmin,xmax,N,Q,mu');
    disp([L,xmin,xmax,2^L,Q,mu]);
    %apply mu-law transform to original sample
    yy=xmax*log10(1+abs(y)*(mu/xmax))/log10(1+mu);
    %apply uniform quantization on the absolute value each sample
    [yq,~]=myquantizer(yy,L);
    %apply inverse mu-law transform to the quantized sequence and take sign of
    %original signal
    xq=(xmax/mu)*(10.^((log10(1+mu)/xmax)*yq)-1).*sign(y);
    %plot waveforms over the entire period
    figure; plot(t,y,'r:',t,xq,'b-');
    axis tight; grid on;legend('original','quantized');
    % Calculate the MSE
    D=y-xq;
    MSE=mean(D.^2);
    fprintf('\n Error between original and quantized = %g\n\n',MSE )
end