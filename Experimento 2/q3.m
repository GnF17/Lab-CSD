%Usando a variável s para fazer a função de transferência
s = tf("s");

%Criando cada bloco do sistema
%G(s) são os blocos superiores
G_in = 4;
G_1 = 1 / (s+1);
G_2 = s / (s^2+2);
G_3 = 1 / (s^2);

%H(s) são as realimentações
H_1 = (4*s+2)/(s^2+2*s+1);
H_2 = 50;
H_3 = (s^2+2)/(s^3+14);

%Juntar G_1 e G_2
G_12 = series (G_1,G_2);

%Malha de G_12 com H_1
Malha_1 = feedback(G_12,H_1);
%Malha de G_3 com H_2
Malha_2 = feedback(G_3,H_2,+1);
%Malha 1 e 2 juntas
Malha_12 = series(Malha_1,Malha_2);
%Malha 1 e 2 com H_3
Malha_3 = feedback(Malha_12,H_3);

%Função de transferência H(s)
H = series(G_in,Malha_3);
H = minreal(H);

disp('Função de transferência H(s) = Y(s)/R(s)')
H

%Gráfico de H(s)
figure;
pzmap(H);
grid on
title('Polos e Zeros de H(s)');

%Polos e Zeros de H(s)
Polos_H = pole(H);
Zeros_H = zero(H);

disp('Polos de H(s)');
disp(Polos_H);

disp('Zeros de H(s)');
disp(Zeros_H);