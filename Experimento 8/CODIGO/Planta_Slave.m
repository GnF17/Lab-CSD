function [sys,x0,str,ts] = Planta_Slave(t,x,u,flag)

sigma = 10;
rho = 28;
beta = 8/3;

switch flag,
   %%%%%%%%%%%%%%%%%
   % Inicialização %
   %%%%%%%%%%%%%%%%%
case 0, 
    sizes = simsizes;
    sizes.NumContStates  = 3; % Número de estados contínuos
    sizes.NumDiscStates  = 0; % Número de estados discretos
    sizes.NumOutputs     = 3; % Número de saídas
    sizes.NumInputs      = 3; % Número de entradas (u1, u2, u3)
    sizes.DirFeedthrough = 0; % Saída depende apenas dos estados x (evita loop algébrico)
    sizes.NumSampleTimes = 1;
    sys = simsizes(sizes);     
    x0 = [0.1; 0.3; -0.1];   % Condições iniciais do escravo (alterar nos testes de CI)
    str = [];
    ts  = [0 0];

   %%%%%%%%%%%%%%
   % Diretivas  %
   %%%%%%%%%%%%%%
case 1, % Sistema de Lorenz (Escravo com controle)
    sys = [sigma * (x(2) - x(1)) + u(1);
           x(1) * (rho - x(3)) - x(2) + u(2);
           x(1) * x(2) - beta * x(3) + u(3)];

   %%%%%%%%%%
   % Saídas %
   %%%%%%%%%%
case 3,
    sys = x;

   %%%%%%%%%
   %  End  %
   %%%%%%%%%
case {2,4,9},
    sys = [];
otherwise
    error(['unhandled flag = ', num2str(flag)]);
end