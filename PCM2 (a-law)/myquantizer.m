function [quant,quantnoise]=myquantizer(t,y,L)
 %Following code is meant to perform uniform quantization on 1Dsignal
% Author: M.Asif Khan mak4086@gmail.com
% Created on 5th August 2014

%Call this function with parameters t,y,L
% where y is the signal:t is sampling duration:L is number of
% quantization Level:quant is quantized signal:quantnoise is quantisation noise 
% To run the code execute following on command window:
% 
% Fs=60000;Ts=1/Fs;f=3000;n=0:Ts:(4/f);y=sin(2*pi*f*n);
% [quant,quantnoise]=myquantizer(n,y,L)
%  
xmax=max(y);xmin=min(y);  
q=(xmax-xmin)/(2^L);
  %Alternative way: comment line 18 and uncomment 15-17
%    for i =1: length(y)
%      quant(i)= round(y(i)*2^(L-1))/(2^(L-1))-sign(y(i))*q/2;
%    end
   quant=floor((y-xmin)/q)*q+xmin;
  quantnoise=mean((y-quant).^2);
 figure,plot(t,y,'r:');hold on 
 stem(t,quant,'b-');axis tight; grid on;legend('original','quantized');
 hold off
 fprintf('\n Error between original and quantized = %g\n\n',quantnoise);
end  