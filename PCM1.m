clc; close all; clear all;

fp = 75;
tp = 1/fp;
t = 0:tp:2-tp;

ac = 10;
fc = 5;
s = ac*sin(2*pi*fc*t);

n = 4;
le = power(2,n);
d = 2*ac/le;

qdb = -ac+d:d:ac-d;
ql = -ac+d/2:d:ac-d/2;

[qi qs] = quantiz(s, qdb, ql);
qsb = de2bi(qi, n, 'left-msb');
[r c] = size(qsb);

esb = [];
jk = 1;
for pq = 1:r;
    for rs = 1:c;
        esb(jk) = qsb(pq, rs);
        jk = jk + 1;
    end
end

ds = reshape(esb, n, length(esb)/n);
des = bi2de(ds','left-msb');
dm = -ac+d/2 + d*des';

subplot(611);
plot(t, s);
xlabel("Time  -->")
ylabel("Amp  -->")
title("Message Signal");
grid on;

subplot(612);
stem(t, s);
title("Sampled Signal");
xlabel("Time  -->")
ylabel("Amp  -->")
grid on;

subplot(613);
title("Quantized Signal");
stairs(t, qs);
xlabel("Time  -->")
ylabel("Amp  -->")
grid on;

subplot(614);
stairs(esb);
xlabel("Time  -->")
ylabel("Amp  -->")
axis([0 length(esb) -.5 1.5])
title("Encoded Signal");
grid on;

subplot(615);
plot(t, dm);
xlabel("Time  -->")
ylabel("Amp  -->")
title("Received Signal");
grid on;