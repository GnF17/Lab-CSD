clear;
clc;
syms s k

den = s^2 + 4*s + 2;
num = s;

G = num / den;
H = 1;

fprintf('G(s):\n');
pretty(G);

fprintf('\nH(s):\n');
disp(H);

L = simplify(G*H);
fprintf('\nFunção de malha aberta L(s) = G(s)H(s):\n');
pretty(L);

T_s = simplify((k*G)/(1 - k*G*H));
fprintf('\nT(s) reconstruída:\n');
pretty(T_s);