function [sys,x0,str,ts] = Sincronizador(t,x,u,flag)

% Parâmetros de acoplamento / ganhos de controle (u_i = -k_i * e_i)
% Para ganho global: use k1 = k2 = k3 = psi
% Para controle subatuado: zere os canais desejados (ex: k1 = 0, k2 = 50, k3 = 0)
k1 = 0;
k2 = 0;
k3 = 50;

switch flag,
   %%%%%%%%%%%%%%%%%
   % Inicialização %
   %%%%%%%%%%%%%%%%%
case 0, 
    sizes = simsizes;
    sizes.NumContStates  = 0; % Controlador puramente algébrico (sem estados internos)
    sizes.NumDiscStates  = 0;
    sizes.NumOutputs     = 3; % Saídas de controle: u(1), u(2), u(3)
    sizes.NumInputs      = 6; % Entradas: mestre u(1:3) e escravo u(4:6)
    sizes.DirFeedthrough = 1; % Saída depende diretamente das entradas u
    sizes.NumSampleTimes = 1;
    sys = simsizes(sizes);       
    x0  = [];
    str = [];
    ts  = [0 0];

   %%%%%%%%%%
   % Saídas %
   %%%%%%%%%%
case 3, % Lei de controle proporcional ao erro e = x_slave - x_master
    sys = [-k1 * (u(4) - u(1));
           -k2 * (u(5) - u(2));
           -k3 * (u(6) - u(3))];

   %%%%%%%%%
   %  End  %
   %%%%%%%%%
case {1,2,4,9},
    sys = [];
otherwise
    error(['unhandled flag = ', num2str(flag)]);
end