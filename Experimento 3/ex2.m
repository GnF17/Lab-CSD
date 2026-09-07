num = [25];
den = [1 1 0];
sys = tf(num,den);
figure;
pzmap(sys);