clear; clc;
syms K s

polinomio = [1, (4 - K), 2];
disp('Polinômio característico:');
disp(polinomio);

routh_tabela = [polinomio(1), polinomio(3);
                polinomio(2), 0];
disp('Tabela de Routh-Hurwitz:');
disp(routh_tabela);

Kcrit = solve(4 - K == 0, K);
Kcrit = double(Kcrit);
disp(['K crítico = ', num2str(Kcrit)]);

pol_crit = subs(polinomio, K, Kcrit);
a2 = double(pol_crit(1));
a1 = double(pol_crit(2));
a0 = double(pol_crit(3));

w = sqrt(a0 / a2);
disp(['Frequência angular de oscilação ω = ', char(vpa(w, 4)), ' rad/s']);
