% [y , fs] = audioread('gtr-nylon22.wav')
% plot(y)


Fs=600;
Ts=1/Fs;
% Ts=1/fs;
f=30;
% f=3000;
n=0:Ts:(4/f);
y=sin(2*pi*f*n);
L=4;
mu=0.56;
[xq]=mulawquan(n,y,L,mu);


% https://www.mathworks.com/matlabcentral/fileexchange/47436-mulawquantizer-zip?s_tid=srchtitle_mu%20law%20quantizer_3