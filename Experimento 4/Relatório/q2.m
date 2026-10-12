syms K s;

B = feedback(tf([1],[1 5 6 0]),tf([1 0],[1]))
disp(B)
[num,den] = tfdata(B,'v')
syms s_sym
num_sym = poly2sym(num, s);
den_sym = poly2sym(den, s);
G_sym = num_sym/den_sym

C = K*G_sym
E = simplify(C/(1+C))

polinomio = [1, 5, 7, K]

routh_tabela = [];

routh_tabela = [routh_tabela,polinomio(1)];
routh_tabela = [routh_tabela,polinomio(3)];
routh_tabela = [routh_tabela;polinomio(2),polinomio(4)];
disp(routh_tabela);

coluna1= routh_tabela(:,1)
coluna2=routh_tabela(:,2)
valor = simplify((-det(routh_tabela)/coluna1(2,1)))
disp(valor)
routh_tabela = [routh_tabela;valor,0]
routh_tabela = [routh_tabela;K,0]
coluna1=routh_tabela(:,1)
solucoes = []

for idx = 1:length(coluna1)
    value = coluna1(idx);
    disp(value)
    solucoes = [solucoes,solve(value>0,K,'ReturnConditions',true).conditions];
end
display(solucoes)