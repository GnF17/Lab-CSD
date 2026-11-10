clear all;
clc;

alpha = 1; 
beta = 1; 

s = tf('s');
G = 1 / ((alpha*s + 1) * (beta*s + 1)); 
H = 1/s;                                

K_estavel = 1;    
K_marginal = 2;  
K_instavel = 3;   

T_estavel = feedback(K_estavel * G, H);
T_marginal = feedback(K_marginal * G, H);
T_instavel = feedback(K_instavel * G, H);

figure;
impulse(T_estavel, T_marginal, T_instavel);
title('Resposta ao Impulso do Sistema em Malha Fechada');
legend('Estável (K=1)', 'Marginal (K=2)', 'Instável (K=3)');
grid on;

xlim([0 30]);
ylim([-6 6]);