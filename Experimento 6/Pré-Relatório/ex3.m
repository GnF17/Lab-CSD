clear; clc; close all;

G = zpk([], [0 -1 -10], 070);
w = 0.1 : 0.1 : 1000;

figure;
bode(G, w);
grid on;

[MG, MF, w_180, w_0dB] = margin(G);
MG_dB = 20 * log10(MG);

fprintf('A fase é 180° na frequência: %g rad/s \n', w_180);
fprintf('A margem de ganho é: %g dB \n\n', MG_dB);
fprintf('O ganho é 0 dB na frequência: %g rad/s \n', w_0dB);
fprintf('A margem de fase é: %g° \n\n', MF);

syms s t
num = 70;
den = s^3 + 11*s^2 + 10*s + 70;
G = num / den;

%Calcula a resposta ao impulso h(t) via Transformada Inversa de Laplace
h = ilaplace(G);

% Exibe o resultado de forma legível e simplificada
disp('A expressão matemática da resposta ao impulso h(t) é:')
pretty(vpa(h, 4))