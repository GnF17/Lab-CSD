clear; clc; close all;

% 1. Definição dos parâmetros do circuito conforme a imagem
R  = 10e3;    % Resistores R1 e R2 = 10 kOhms
C  = 5e-3;    % Capacitores C1 e C2 = 5 mF
Ra = 10e3;    % Valor a partir da matrícula

% 2. Cálculo do R_b crítico para estabilidade marginal
% (Ocorre quando o coeficiente de 's' zera: 2 - Rb/Ra = 0)
Rb_critico = 2 * Ra; % Resultado será 20 kOhms

% Testaremos 3 casos: Estável (-10%), Marginal (exato) e Instável (+10%)
Rb_values = [0.9*Rb_critico, Rb_critico, 1.1*Rb_critico];

figure;
hold on;

% 3. Loop para gerar a Função de Transferência e simular o degrau para cada caso
for i = 1:length(Rb_values)
    Rb = Rb_values(i);
    
    % Ganho não inversor K
    K = 1 + Rb/Ra; 
    
    % Numerador e Denominador de H(s)
    num = K;
    den = [R^2 * C^2, (2 - Rb/Ra)*R*C, 1];
    
    % Criação da Função de Transferência
    sys = tf(num, den);
    
    % Simulação da Resposta ao Degrau
    % O tempo de simulação é alto (t=2000) devido à grande constante de tempo RC (50s)
    t = 0:0.1:2000;  
    [y, t] = step(sys, t);
    
    plot(t, y, 'LineWidth', 1.8);
end

% 4. Formatação do Gráfico
legend(arrayfun(@(Rb) sprintf('Rb = %.1f k\\Omega', Rb/1000), Rb_values, 'UniformOutput', false), 'Location', 'best');
xlabel('Tempo (s)');
ylabel('Tensão de Saída v_o(t) [V]');
title('Resposta ao Degrau para 3 Casos de Estabilidade');
grid on;
hold off;