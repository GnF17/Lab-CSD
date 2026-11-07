clear; clc; close all;

K = input('Digite o valor do ganho K: ');

G = zpk([], [-5 -20 -50], 10000 * K);

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