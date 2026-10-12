clear; clc;

Kcrit = 4;

num = Kcrit * [1 0];          
den = [1 (4 - Kcrit) 2];      

T_s = tf(num, den);

figure;
rlocus(T_s);
title('LGR de T(s) com K = Kcrit');
grid on;

p = pole(T_s);
disp('Polos de T(s) com K = Kcrit:');
disp(p);