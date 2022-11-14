clc; clear all; close all;

pn=1000;
pt=1/pn;
b = [1 0 0 1 1 0 0 1 1 0];
t = 0:pt:10-pt;

ms=[];
mso=[];
mse=[];

for jk=1:length(b)
    ms = [ms repmat(b(jk), 1, pn)];
    if(mod(jk,2)~=0)
        mso = [mso repmat(2*b(jk)-1,1,2*pn)];
    else
        mse = [mse repmat(2*b(jk)-1,1,2*pn)];
    end
end

fc=1;
st = mso.*cos(2*pi*fc*t) + mse.*sin(2*pi*fc*t);
ns=0;
stn = awgn(st, ns);

rs1 = stn.*cos(2*pi*fc*t);
rs2 = stn.*sin(2*pi*fc*t);

ss1 = [];
ss2 = [];
for jk=1:length(b)/2
    ss1 = [ss1 sum(rs1(1, (jk-1)*2*pn+1:jk*2*pn))];
    ss2 = [ss2 sum(rs2(1, (jk-1)*2*pn+1:jk*2*pn))];
end
ss1 = ss1/pn;
ss2 = ss2/pn;

vt=0;
ds = [];
for jk=1:length(b)/2
    if ss1(jk)>=vt
        ts=1;
    else
        ts=0;
    end
    ds = [ds repmat(ts,1,pn)];

    if ss2(jk)>=vt
        ts=1;
    else
        ts=0;
    end
    ds = [ds repmat(ts,1,pn)];
end

sig_amp = max(stn)-max(st)

figure(1)
subplot(411)
plot(t,ms, 'LineWidth',2.5)
xlabel("Time  -->")
ylabel("Amp -->")
title("Digital Signal");
grid on;

subplot(412)
plot(t,mso, 'LineWidth',2.5)
xlabel("Time  -->")
ylabel("Amp -->")
title("Odd Bit Signal");
grid on;

subplot(413)
plot(t,mse, 'LineWidth',2.5)
xlabel("Time  -->")
ylabel("Amp -->")
title("Even Bit Signal");
grid on;

subplot(414)
plot(t,st)
xlabel("Time  -->")
ylabel("Amp -->")
title("QPSK Signal");
grid on;

figure(2)
subplot(411)
plot(t,stn)
xlabel("Time  -->")
ylabel("Amp -->")
title("QPSK Signal with Noise");
grid on;

subplot(412)
plot(t,rs1)
xlabel("Time  -->")
ylabel("Amp -->")
title("Detection of Signal in one arm");
grid on;

subplot(413)
plot(t,rs2)
xlabel("Time  -->")
ylabel("Amp -->")
title("Detection of Signal in second arm");
grid on;

subplot(414)
plot(t,ds, 'LineWidth', 2.5)
xlabel("Time  -->")
ylabel("Amp -->")
title("Received Digital Signal");
grid on;