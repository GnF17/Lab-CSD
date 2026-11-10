clear all;
clc;
close all;

alpha = 1; 
beta = 1;  

s = tf('s');
G = 1 / ((alpha*s + 1) * (beta*s + 1)); 
H = 1/s;                                
L_base = G * H; 

K_estavel = 1;    
K_marginal = 2;   
K_instavel = 3;   

L_estavel = K_estavel * L_base;
L_marginal = K_marginal * L_base;
L_instavel = K_instavel * L_base;

figure;
nyquist(L_estavel, L_marginal, L_instavel);
legend('Estável (K=1)', 'Marginal (K=2)', 'Instável (K=3)', 'Location', 'southeast');
title('Diagrama de Nyquist para diferentes valores de K');
grid on;
xlim([-2 1]);
ylim([-2 2]);

hold on; 
plot(-1, 0, 'r+', 'MarkerSize', 10, 'LineWidth', 2, 'HandleVisibility', 'off'); 
hold off;