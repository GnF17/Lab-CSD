clear al; close all;

s = tf('s');
G = 1 / (s^2 + 2*s + 2);
H = 1 / (s + 2);
GH = G * H;

% Definindo os ganhos para os 3 casos de estabilidade
K_estavel = 10;       % Caso Estável (K < 20)
K_marginal = 20;      % Caso Marginalmente Estável (K = 20)
K_instavel = 30;      % Caso Instável (K > 20)

% Plot 1: Estável
figure(1);
nyquist(K_estavel * GH);
title('Estável (K=10)');
axis([-1.5 0.5 -1 1]);

% Plot 2: Marginalmente Estável
figure(2);
nyquist(K_marginal * GH);
title('Marginal (K=20)');
axis([-1.5 0.5 -1 1]);

% Plot 3: Instável
figure(3);
nyquist(K_instavel * GH);
title('Instável (K=30)');
axis([-2 0.5 -1.5 1.5]);