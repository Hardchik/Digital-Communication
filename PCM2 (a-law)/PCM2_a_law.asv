% [y , fs] = audioread('gtr-nylon22.wav');
% plot(y)

Fs=60000;
Ts=1/Fs;
% Ts=1/fs;
f=3000;
n=0:Ts:(4/f);
y=sin(2*pi*f*n);
L=4;
A=1;

[xq]=Alawquan(n,y,L,A);