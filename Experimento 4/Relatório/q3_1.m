clear;
clc;

syms s R C k Vi V1 Va Vo

R_val = 100e3;  
C_val = 10e-6;  


eq1 = (V1 - Vi)/R + s*C*V1 + s*C*(V1 - Va) + (V1 - Vo)/R == 0;

eq2 = s*C*(Va - V1) + Va/R == 0;

eq3 = Vo == k * Va;

sol = solve([eq1, eq2, eq3], [V1, Va, Vo]);

Ts_symbolic = simplify(sol.Vo / Vi);
Ts_numeric = simplify(subs(Ts_symbolic, [R, C], [R_val, C_val]));

fprintf('A função de transferência de malha fechada T(s) é:\n');
pretty(Ts_numeric);