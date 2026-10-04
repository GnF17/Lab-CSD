%Usando a variável s para fazer a função de transferência
s = tf("s");

%Criando cada bloco do sistema
R_in = 1;
K_1 = 63;
Motor = 25 / (s*(s+1));
Tacometro = 1.6*s;

%Malha do Motor com Tacometro
Malha_1 = feedback(Motor, Tacometro);
%Malha 1 somada com K1
Malha_Amp_M_T = series(K_1,Malha_1);
%Realimentacao do sistema
Sistema = feedback(Malha_Amp_M_T,1);
%Acrescentando a entrada
Sistema_Final = series(R_in,Sistema);

Sistema_Final = minreal(Sistema_Final);

disp('Função de Transferência do Sistema em Malha Fechada:')
Sistema_Final

figure;
step(Sistema_Final);
title('Resposta ao Degrau Unitário');
ylabel('Posição C(t)');
grid on;

info = stepinfo(Sistema_Final);

fprintf('\n--- Resultados da Simulação ---\n');
fprintf('Ultrapassagem Percentual (%%OS): %.2f %%\n', info.Overshoot);
fprintf('Instante de Pico (tp): %.4f segundos\n', info.PeakTime);

% Análise de Polos e Zeros
figure;
pzmap(Sistema_Final);
grid on;
title('Mapa de Polos e Zeros do Sistema');

% Extração dos polos para exibição no Command Window
Polos_Malha_Fechada = pole(Sistema_Final);

% Salva a Figura 1 (Resposta ao Degrau)
exportgraphics(figure(1), 'Q1_Resposta_Degrau.png', 'Resolution', 300);

% Salva a Figura 2 (Mapa de Polos e Zeros)
exportgraphics(figure(2), 'Q1_Mapa_Polos_Zeros.png', 'Resolution', 300);

disp('Gráficos salvos com sucesso na pasta atual!');