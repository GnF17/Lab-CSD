syms K;

polinomio = [(1+K),(-6+8*K),(8+15*K),0]

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