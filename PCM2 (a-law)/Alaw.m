function [C,xmax]=Alaw(x,A)
%   Non-linear Quantization
%   A-law: A-law nonlinear quantization
%   x : input vector
%   C: A-law compressor output
%   Xmax : maximum of input vector x
  xmax  = max(abs(x));
  for i = 1:length(x)
    if(0<abs(x(i)/xmax)<=1/A)
      C(i) = A*abs(x(i)/xmax)./(1+log10(A));
    elseif((1/A)<abs(x(i)/xmax)<=1)
      C(i) = (1+log10(A*abs(x(i)/xmax)))./(1+log10(A));
    end
  end
  C = C.*sign(x)/xmax; %normalization of output vector
end