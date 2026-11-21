function [sys,x0,str,ts] = Planta_Master(t,x,u,flag)

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
    sizes.NumInputs      = 0; % Número de entradas
    sizes.DirFeedthrough = 0; % Saída não depende diretamente da entrada
    sizes.NumSampleTimes = 1;
    sys = simsizes(sizes);     
    x0  = [1.5; 2; 5];        % Condições iniciais do mestre
    str = [];
    ts  = [0 0];

   %%%%%%%%%%%%%%
   % Diretivas  %
   %%%%%%%%%%%%%%
case 1, % Sistema de Lorenz (Mestre)
    sys = [sigma * (x(2) - x(1));
           x(1) * (rho - x(3)) - x(2);
           x(1) * x(2) - beta * x(3)];

   %%%%%%%%%
   % Saída %
   %%%%%%%%%
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