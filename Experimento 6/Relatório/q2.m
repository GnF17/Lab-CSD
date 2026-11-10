clear all;
clc;
close all;

syms s V1 V2 Vs R1 R2 C1 C2 K

Zc1 = 1/(s*C1);
Zc2 = 1/(s*C2);

eq1 = (V2 - V1)/R1 + V2/Zc1 == 0;

eq2 = Vs == (K*V2) * (R2 / (R2 + Zc2));

sol = solve([eq1, eq2], [V2, Vs]);

Gs = sol.Vs / V1;
Gs = simplify(Gs); 

fprintf('Funcao de Transferencia G(s)\n');
pretty(Gs);

R1_val = 1e3;       
C1_val = 100e-12; 
R2_val = 1e3;       
C2_val = 1e-6;     
K_val  = 100;

vars = [R1, R2, C1, C2, K];
vals = [R1_val, R2_val, C1_val, C2_val, K_val];
Gs_numerical = subs(Gs, vars, vals);

[num, den] = numden(Gs_numerical); 
G_tf = tf(sym2poly(num), sym2poly(den));

fprintf('G(s) com valores numéricos:');
G_tf

w = logspace(0, 10, 1000); 
figure;
bode(G_tf, w);
grid on;
title('Diagrama de Bode de G(s)');