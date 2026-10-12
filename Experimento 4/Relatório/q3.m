clear; clc; close all;

Ra = 10e3;
R  = 10e3;
C  = 5e-3;

Rb_critico = 54e3;
Rb_values = [0.9*Rb_critico, Rb_critico, 1.1*Rb_critico];

figure;
hold on;
for i = 1:length(Rb_values)
    Rb = Rb_values(i);
    num = 1 + Rb/Ra;
    den = [R^2*C^2, (2 - Rb/Ra)*R*C, 1];
    sys = tf(num, den);
    t = 0:0.1:1000;  
    [y, t] = step(sys, t);
    plot(t, y, 'LineWidth', 1.8);
end

legend(arrayfun(@(Rb) sprintf('Rb = %.1f kΩ', Rb/1000), Rb_values, 'UniformOutput', false), 'Location', 'best');
xlabel('Tempo (s)');
ylabel('Amplitude');
title('Resposta ao degrau para diferentes valores de R_b');
grid on;
hold off;