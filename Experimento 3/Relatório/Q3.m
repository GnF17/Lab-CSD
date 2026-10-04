% Parâmetros do circuito do projeto
R1 = 1e6; % 1 M Ohm
R2 = 8444.8;
L = 1;
C = 21.97e-9;

% Fatores da equação característica
Fator = 1 + (R2 / R1);
Termo_Constante = 1 / (L * C * Fator);
Termo_s = (C * R2 + L / R1) / (L * C * Fator);

% Criação da Função de Transferência
s = tf('s');
Vc_Vi = Termo_Constante / (s^2 + Termo_s * s + Termo_Constante);

disp('Função de Transferência Teórica (Tensão no Condensador):');
Vc_Vi = minreal(Vc_Vi)

% Simulação e Extração de Requisitos
figure;
step(Vc_Vi);
title('Resposta Teórica ao Degrau - Circuito RLC');
ylabel('Tensão V_c(t)');
grid on;

info = stepinfo(Vc_Vi);

fprintf('\n--- Validação Teórica ---\n');
fprintf('Ultrapassagem Percentual (%%OS): %.2f %%\n', info.Overshoot);
fprintf('Instante de Pico (tp): %.6f segundos\n', info.PeakTime);

% Exportar a figura para o relatório
exportgraphics(gcf, 'Q3_Validacao_Teorica.png', 'Resolution', 300);
disp('Gráfico guardado com sucesso na diretoria atual.');