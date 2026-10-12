% Definição da função de transferência em malha aberta G(s)

% [K(s+3)]/[s^4 + 7s^3 + 14s^2 + (8+k)s + 3k]

% K = 9,65

numerador = [1 3]; % Zero em s = -3
denominador = poly([0 -1 -2 -4]); % Polos em 0, -1, -2, -4
Gs = tf(numerador, denominador);

% Traçar o LGR
figure;
rlocus(Gs);
title('Lugar Geométrico das Raízes (LGR)');
grid on;