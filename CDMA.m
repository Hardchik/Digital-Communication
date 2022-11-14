clc; clear all; close all;

b = [1 0 1 1 0];
n = length(b);
pn = 1000;
pt = 1/pn;
t = 0:pt:n-pt;
ms = [];
for jk=1:n
    ms = [ms repmat(2*(b(jk))-1,1,pn)];
end
c = 4;
cpn = pn/c;
r = [1 -1 1 -1];
r = repmat(r,1,n);
pns = [];
for jk=1:length(r)
    pns = [pns repmat(r(jk),1,cpn)];
end
es = ms.*pns;
fc = 10;
cs = cos(2*pi*fc*t);
st = es.*cs;
na = 2;
ns = na*(rand(1,length(t))-0.5);
stn = st+ns;

rs = stn.*cs;
ss= [];
for jk=1:n*c
    ss = [ss sum(rs(1,(jk-1)*cpn+1:jk*cpn))];
end
ss =ss/pn;

vt = 0;
dse = [];
for jk=1:n*c
    if ss(jk)>=vt
        ts=1;
    else
        ts=-1;
    end
    dse = [dse repmat(ts,1,cpn)];
end
ds = dse.*pns;

figure(1)
subplot(511)
plot(t,ms, 'LineWidth',2.5)
title("Message Signal");
xlabel("Time  -->")
ylabel("Amp -->")
grid on;

subplot(512)
plot(t,pns, 'LineWidth',2.5)
title("Code Signal");
xlabel("Time  -->")
ylabel("Amp -->")
grid on;

subplot(513)
plot(t,es, 'LineWidth',2.5)
title("Transmitted Signal");
xlabel("Time  -->")
ylabel("Amp -->")
grid on;

subplot(514)
plot(t,cs, 'LineWidth',2.5)
title("Cosine Signal");
xlabel("Time  -->")
ylabel("Amp -->")
grid on;

subplot(515)
plot(t,st, 'LineWidth',2.5)
title("Modulated Signal");
xlabel("Time  -->")
ylabel("Amp -->")
grid on;

figure(2)
subplot(511)
plot(t,stn)
title("Modulated Signal with Noise");
xlabel("Time  -->")
ylabel("Amp -->")
grid on;

subplot(512)
plot(t,rs)
title("Demodulated Signal");
xlabel("Time  -->")
ylabel("Amp -->")
grid on;

subplot(513)
plot(t,dse, 'LineWidth',2.5)
title("Filtered Signal");
xlabel("Time  -->")
ylabel("Amp -->")
grid on;

subplot(514)
plot(t,pns, 'LineWidth',2.5)
title("Code Signal");
xlabel("Time  -->")
ylabel("Amp -->")
grid on;

subplot(515)
plot(t,ds, 'LineWidth',2.5)
title("Received Signal");
xlabel("Time  -->")
ylabel("Amp -->")
grid on;