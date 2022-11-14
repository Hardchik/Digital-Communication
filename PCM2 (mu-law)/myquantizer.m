function [quant,quantnoise]=myquantizer(y,L)
 
xmax=max(y);xmin=min(y);  
q=(xmax-xmin)/(2^L);
  for i =1: length(y)
    quant(i)= round(y(i)*2^(L-1))/(2^(L-1))-sign(y(i))*q/2;
  end
  quantnoise=mean((y-quant).^2);
% figure; plot(t,y,'r:',t,quant,'b-');
% axis tight; grid on;legend('original','quantized');
% fprintf('\n Error between original and quantized = %g\n\n',quantnoise)
end  