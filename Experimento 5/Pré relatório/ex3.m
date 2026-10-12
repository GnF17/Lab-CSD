% T(s) = 1/ [s^2 + alpha s + 1]
% Geq(s) = 1 + alpha[s/(s^2 + 1)]

% Definir o numerador e denominador da função equivalente
% Numerador: s -> [1 0]
% Denominador: s^2 + 1 -> [1 0 1]
num = [1 0];
den = [1 0 1];

% Criar a função de transferência equivalente
G_eq = tf(num, den);

% Traçar o LGR
figure;
rlocus(G_eq);
title('Lugar Geométrico das Raízes variando o parâmetro \alpha');
xlabel('Eixo Real');
ylabel('Eixo Imaginário');
grid on;