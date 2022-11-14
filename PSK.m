clc; clear all; close all;

pn =1000;
pt=1/pn;
s = [1 0 0 1 1 0 0 1 1 0];
t = 0:pt:10-pt;

es=[];
for jk=1:length(s)
    for qr=1:pn
        es = [es s(jk)];
    end
end

b = [];
for jk=1:length(s)
    if s(jk)==1
        sa=1;
    else
        sa=-1;
    end
    b = [b sa];
end

ms=[];
for jk=1:length(b)
    for qr=1:pn
        ms = [ms b(jk)];
    end
end

ac=4; fc=5;
cs=ac*sin(2*pi*fc*t);
st = ms.*cs;

na = 2;
ns = na*[rand(1, length(t))-0.5];
stn = st+ns;
rs = stn.*cs;

ss = [];
for jk = 1:length(b)
    qs=0;
    for qr=1:pn
        qs = qs + rs((jk-1)*pn+qr);
    end
    ss = [ss qs];
end
ss = ss/pn;

vt = ac^2/4;
ds = [];
for jk = 1:length(b)
    if ss(jk)>=vt
        ts=1;
    else
        ts=0;
    end

    for qr=1:pn
        ds = [ds ts];
    end
end

sig_amp = max(stn)-max(st)

figure(1)
subplot(411)
plot(t,es, 'LineWidth',2.5)
xlabel("Time  -->")
ylabel("Amp -->")
title("Digital Signal");
grid on;

subplot(412)
plot(t,ms, 'LineWidth',2.5)
xlabel("Time  -->")
ylabel("Amp -->")
title("Digital Polar Signal");
grid on;

subplot(413)
plot(t,cs)
xlabel("Time  -->")
ylabel("Amp -->")
title("Carrier Signal");
grid on;

subplot(414)
plot(t,st)
xlabel("Time  -->")
ylabel("Amp -->")
title("PSK Signal");
grid on;

figure(2)
subplot(411)
plot(t,ns)
xlabel("Time  -->")
ylabel("Amp -->")
title("Noise Signal");
grid on;

subplot(412)
plot(t,stn)
xlabel("Time  -->")
ylabel("Amp -->")
title("PSK Signal with Noise");
grid on;

subplot(413)
plot(t,rs)
xlabel("Time  -->")
ylabel("Amp -->")
title("Detected Signal");
grid on;

subplot(414)
plot(t,ds, 'LineWidth', 2.5)
xlabel("Time  -->")
ylabel("Amp -->")
title("Received Digital Signal");
grid on;