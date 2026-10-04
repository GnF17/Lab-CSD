K = [1:1:5000]; % Define a faixa para K de 1 a 5000
for n = 1:length(K)
den = [1 18 77 K(n)]; % Denominador para o en´esimo valor de K
polos = roots(den); % Calcula os polos para o en´esimo valor de K
r = real(polos); % Vetor contendo a parte real dos polos
if max(r)>=0 % Testa se a parte real dos polos ´e > ou = 0
polos % Exibe os polos com parte real > ou = 0
K = K(n) % Exibe o valor correspondente de K
break % Interrompe o laço se houver polos no SPD
end % Final do if
end % Final do for