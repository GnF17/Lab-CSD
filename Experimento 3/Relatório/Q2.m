% Definição dos parâmetros do sistema mecânico
M = 2;
b = 5;
K = 3;

% Criação da Função de Transferência
s = tf('s');
Sistema = 1 / (M*s^2 + b*s + K);

disp('Função de Transferência do Sistema:');
Sistema

% Obtenção da Resposta ao Impulso
figure;
impulse(Sistema);
grid on;
title('Resposta Teórica ao Impulso Unitário');
ylabel('Posição x(t)');
xlabel('Tempo (segundos)');

% Exportando o gráfico para o relatório
exportgraphics(gcf, 'Q2_Resposta_Impulso.png', 'Resolution', 300);
disp('Gráfico da resposta ao impulso salvo com sucesso!');