clear all;
clc;

syms s K alpha beta

G = 1 / ((alpha*s + 1) * (beta*s + 1)); 
H = 1/s;                                
L = K * G * H;

fprintf('G(s) =\n');
pretty(G);
fprintf('H(s) =\n');
pretty(H);
fprintf('L(s) =\n');
pretty(L);

syms w
L_jw = subs(L, s, 1i*w);
fprintf('1. Mapeamento L(jw) = L(s) | s=jw \n');
pretty(L_jw);
A = -w^2 * (alpha + beta);
B = w * (1 - alpha*beta*w^2);
fprintf('2. A frequencia de cruzamento ocorre quando a parte imaginária é zero.\n');
fprintf('%s = 0\n\n', B);

syms w_sq
eq_wc = subs(B/w, w^2, w_sq) == 0;

w_c_squared_sol = solve(eq_wc, w_sq);

fprintf('A frequencia de cruzamento ao quadrado é:\n');
fprintf('w_c^2 = %s\n\n', char(w_c_squared_sol));

crossover_point = K / (subs(A, w^2, w_c_squared_sol));

crossover_point = simplify(crossover_point);
fprintf('3. Substituindo w_c^2 em L(jw), o ponto de cruzamento é:\n\n');
fprintf('Ponto de Cruzamento = %s\n', char(crossover_point));