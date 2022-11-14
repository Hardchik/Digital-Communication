clc; close all; clear all;

[y, fs] = audioread("gtr-nylon22.wav");
info = audioinfo("gtr-nylon22.wav");

pn = fs;
pt = 1/pn;

jk = y';
s = exp(20*jk);
mn = length(s)/fs;
t = 0:pt:mn-pt;

vmax = max(s);
vmin = min(s);

n=6;
le = 2^n;
d=(vmax-vmin)/le;

qdb = vmin+d:d:vmax-d;
ql = vmin+d/2:d:vmax-d/2;
[qi, qs, ds] = quantiz(s, qdb, ql);

lp=255;

cu = compand(s,lp,vmax,'mu/compressor');
[qiu, qsu, dsu] = quantiz(cu, qdb, ql);
cu = compand(qsu, lp, max(qsu),'mu/expander');

ca = compand(s,lp,vmax,'A/compressor');
[qia, qsa, dsa] = quantiz(ca, qdb, ql);
ca = compand(qsa, lp, max(qsa),'A/expander');

l_distortion = ds
u_distortion = dsu
a_distortion = dsa

subplot(411)
plot(t,s)
title("Audio Signal");
xlabel('Time --->')
ylabel('Amp --->')
grid on;

subplot(412)
plot(t,qs)
title("Linear Quantization");
xlabel('Time --->')
ylabel('Amp --->')
grid on;

subplot(413)
plot(t,cu)
title("Non-linear PCM with mu-law");
xlabel('Time --->')
ylabel('Amp --->')
grid on;

subplot(414)
plot(t,ca)
title("Non-linear PCM with A-law");
xlabel('Time --->')
ylabel('Amp --->')
grid on;