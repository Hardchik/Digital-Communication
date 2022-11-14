function [C,xmax]=invAlaw(x,A)
%   Non-linear Quantization
%   Xmax: maximum of input vector x
%   C: A-law expander output
  xmax  = max(abs(x));
  for i = 1:length(x)
    if(0<abs(x(i)/xmax)<=(1/1+log10(A)))
        C(i)=(((x(i)/xmax).*(1+log10(A)))/A);
    elseif((1/1+log10(A))<abs(x(i)/xmax)<1)
        C(i) = (1/A).*10.^((x(i)/xmax)*(1+log10(A))-1);
    end
  end
  C = C/xmax; %normalization of output vector
end