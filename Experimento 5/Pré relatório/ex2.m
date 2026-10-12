% Definição da função de transferência em malha aberta G(s)

% [K(s^2 - 4s + 20)]/[(s+2)(s+4)]

% Ganho = 1.1
% Polos -0.381+-j3.76

numGH = [1 -4 20]; % Define o numerador de G(s)H(s)
denGH = [1 6 8]; % Define o denominador de G(s)H(s)

GH = tf(numGH, denGH) % Cria G(s)H(s)
rlocus(GH) % Tra¸ca o LGR

xi = 0.1:0.1:0.9; % Define valores do fator de amortecimento variando de 0,1 a 0,9
wn = 0:1:10; % Define valores de frequencia natural variando de 0 a 10 rad/s

sgrid(xi,wn) % Gera grade de retas de fator de amortecimento e de frequencia natural

pause

rlocus(GH) % Traça o LGR

axis([-3 0 -4 4]) % Define faixas dos eixos do LGR para visualizaçao ampliada

xi = 0.1; % Define a reta de fator de amortecimento para sobrepor ao lugar das raızes 
% O último dígito é 0, então foi considerado o penultimo que é 1 -> 1/10 
% fator de amortecimento ξ = 0.1
wn = 0; % Suprime curvas sobrepostas de frequencia natural

sgrid(xi,wn) % Sobrepoe a curva de fator de amortecimento ao LGR

for n = 1:3 % Este laço permite selecionar tres
    [K,p] = rlocfind(GH) % pontos do LGR, mostrando o ganho e os polos em malha fechada
end