clc; close all;
clear all;
pn=1000;
pt=1/pn;
b=[1 0 1 1 0 1 0 0 1 0];
t=0:pt:length(b)-pt;

ms=[];
mso=[];
mse=[];

for jk = 1:length(b)
    ms=[ms repmat(b(jk),1,pn)];
    if (mod(jk,2)~=0)
        mso=[mso repmat(2*b(jk)-1, 1, 2*pn)];
    else
        mse=[mse repmat(2*b(jk)-1, 1, 2*pn)];
    end
end

fc = 1;
st = mso.*cos(2*pi*fc*t) + mse.*sin(2*pi*fc*t);
sn=0;
stn=awgn(st,sn);

rs1=stn.*cos(2*pi*fc*t);
rs2=stn.*sin(2*pi*fc*t);

ss1=[];
ss2=[];
for jk=1:length(b)/2
    ss1 = [ss1 sum(rs1(1, (jk-1)*2*pn+1:jk*2*pn))];
    ss2 = [ss2 sum(rs2(1, (jk-1)*2*pn+1:jk*2*pn))];
end
ss1=ss1/pn;
ss2=ss2/pn;

vt=0;
ds=[];
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

subplot(811)
plot(t,ms,'Linewidth',3);
subplot(812)
plot(t,mso,'Linewidth',3);
subplot(813)
plot(t,mse,'Linewidth',3);
subplot(814)
plot(t,st);
subplot(815)
plot(t,stn);
subplot(816)
plot(t,rs1);
subplot(817)
plot(t,rs2);
subplot(818)
plot(t,ds,'Linewidth',3);