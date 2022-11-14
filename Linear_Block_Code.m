clc; clear all; close all;

P = [1 1 0;
    0 1 1;
    1 1 1;
    1 0 1]
n = 7
k = 4

G = [P eye(k)]
H = [eye(n-k) P']

d = [0:2^k-1]
m = de2bi(d,4,'left-msb')

C = mod(m*G,2)

y = [1 0 0 1 0 0 1]

'H Transpose'
ht = H'
s = mod(y*H',2)