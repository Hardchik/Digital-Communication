% ============
% PCM ENCODING
% ============
f = 2;
fs = 20;
Ts = 1/fs;
fss = 1.e4;
Tss = 1/fss;
t = 0:Tss:2-Tss;
d = Ts/40:Ts:2+Ts/40;
p = pulstran(t,d,'rectpuls',1/(fs*40));
% =================
% Analog MSG Signal
% =================
m = sin(2*pi*f*t)+1.1;
% =================
% Sampled signal
% =================
ms = m.*p;
% =================
% Quantized Msg
% =================
qm = quant(ms,2/16);
em = 8*(qm);
% =================
% ENCODING MSG
% =================
j = 1;
for i=1:length(em)
    if ((((i>1)&&(em(i)~=em(i-1)))||(i==1))&&(em(i)~=0))
        x(j) = em(i)-1;
        j=j+1;
    end
end
z = dec2bin(x,5);
z = z';
z = z(:);
z = str2num(z);
s = 2*(z')-1;
Tb = 2/length(s);
fb = 0.5/Tb;
BL = Tb/Tss;
y = ones(BL,1);
bit = 5*y*s;
bit = bit(:);
bit = bit';                     % Polar NRZ bit stream
% =============
% PCM DE-CODING
% =============
rb = bit(ceil(Tb/(Tss)):(Tb/Tss):length(bit));
rb = (rb+5)/10;
l = length(rb);
for i = 1:l/5
    q = rb((5*i)-4:5*i);
    q = num2str(q);
    x1(i) = bin2dec(q);
    e(i) = x1(i)+1;
end
e = e/8;
y1 = ones(1,ceil((Ts/40)/Tss));
y2 = zeros(1,(Ts/Tss)-length(y1));
y3 = [y1 y2];
y3 = y3';
ms1 = y3*e;                     % Sampled signal from Encoded Signal
ms1 = ms1(:);
% Filtering Sampled Signal
[n,w] = buttord(f/fss,(f+1)/fss,.6,4);
[a,b] = butter(n,w,'low');
rm = filter(a,b,ms1);
rm = rm*50;                     % Recieved Orignal Signal
% ==================
% Plotting Signals
% ==================
figure(1);
subplot(2,1,1)
plot(t,m,'b',t,ms,'r');
legend('Analog Msg','Sampled Msg')
grid;
xlabel('t -->');
ylabel('Amplitude');
axis([0 2 0 2.25]);
subplot(2,1,2)
plot(t,ms,'k',t,qm,'r');
legend('Sampled Msg','Quantized Msg')
grid;
xlabel('t -->');
ylabel('Amplitude');
axis([0 2 0 2.25]);
figure(2);
subplot(2,1,1)
plot(t,em,'b')
xlabel('t -->');
ylabel('Amplitude');
title('Leveled Msg');
grid;
axis([0 2 -0.5 16.5]);
subplot(2,1,2)
plot(t,bit,'k')
xlabel('t -->');
ylabel('Amplitude');
title('POLAR NRZ ENCODED');
grid;
axis([0 2 -5.25 5.25]);
figure(3);
subplot(2,1,1)
plot(t,ms1,'b');
title('Recovered Sampled Msg')
grid;
xlabel('t -->');
ylabel('Amplitude');
axis([0 2 0 2.25]);
subplot(2,1,2)
plot(t,rm,'b');
title('Recovered Analog Msg')
grid;
xlabel('t -->');
ylabel('Amplitude');
axis([0 2 0 2.25]);