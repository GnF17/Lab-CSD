% Gera e salva automaticamente os gráficos da sincronização mestre-escravo (Lorenz)
clc;
fsize = 20;
set(0, 'DefaultAxesFontSize', 16);

% Definição padronizada do erro: e = x_slave - x_master (mesmo padrão do Sincronizador.m)
e1 = Xslave(:,1) - Xmaster(:,1);
e2 = Xslave(:,2) - Xmaster(:,2);
e3 = Xslave(:,3) - Xmaster(:,3);

% ==================== FIGURA 1: Estado x ====================
fig = figure;
plot(t, Xmaster(:,1), t, Xslave(:,1), ':', 'LineWidth', 2);
grid on; grid minor;
h = legend('Mestre', 'Escravo', 'Location', 'northeast');
set(h, 'FontSize', fsize);
xlabel('Tempo (s)', 'FontSize', fsize);
ylabel('$$x_{m}(t),\, x_{s}(t)$$', 'Interpreter', 'Latex', 'FontSize', fsize);
title('Sincronização do Estado x (Mestre vs Escravo)', 'FontSize', fsize);
set(gcf, 'units', 'normalized', 'outerposition', [0 0 1 1]);
saveas(gcf, 'FIG1.png');
saveas(gcf, 'FIG1.fig');
close(fig);

% ==================== FIGURA 2: Estado y ====================
fig = figure;
plot(t, Xmaster(:,2), t, Xslave(:,2), ':', 'LineWidth', 2);
grid on; grid minor;
h = legend('Mestre', 'Escravo', 'Location', 'northeast');
set(h, 'FontSize', fsize);
xlabel('Tempo (s)', 'FontSize', fsize);
ylabel('$$y_{m}(t),\, y_{s}(t)$$', 'Interpreter', 'Latex', 'FontSize', fsize);
title('Sincronização do Estado y (Mestre vs Escravo)', 'FontSize', fsize);
set(gcf, 'units', 'normalized', 'outerposition', [0 0 1 1]);
saveas(gcf, 'FIG2.png');
saveas(gcf, 'FIG2.fig');
close(fig);

% ==================== FIGURA 3: Estado z ====================
fig = figure;
plot(t, Xmaster(:,3), t, Xslave(:,3), ':', 'LineWidth', 2);
grid on; grid minor;
h = legend('Mestre', 'Escravo', 'Location', 'northeast');
set(h, 'FontSize', fsize);
xlabel('Tempo (s)', 'FontSize', fsize);
ylabel('$$z_{m}(t),\, z_{s}(t)$$', 'Interpreter', 'Latex', 'FontSize', fsize);
title('Sincronização do Estado z (Mestre vs Escravo)', 'FontSize', fsize);
set(gcf, 'units', 'normalized', 'outerposition', [0 0 1 1]);
saveas(gcf, 'FIG3.png');
saveas(gcf, 'FIG3.fig');
close(fig);

% ==================== FIGURA 4: Erro e_1 ====================
fig = figure;
plot(t, e1, 'LineWidth', 2);
grid on; grid minor;
xlabel('Tempo (s)', 'FontSize', fsize);
ylabel('$$e_1(t) = x_s(t) - x_m(t)$$', 'Interpreter', 'Latex', 'FontSize', fsize);
title('Erro de Sincronização do Estado x (e_1)', 'FontSize', fsize);
set(gcf, 'units', 'normalized', 'outerposition', [0 0 1 1]);
saveas(gcf, 'FIG4.png');
saveas(gcf, 'FIG4.fig');
close(fig);

% ==================== FIGURA 5: Erro e_2 ====================
fig = figure;
plot(t, e2, 'LineWidth', 2);
grid on; grid minor;
xlabel('Tempo (s)', 'FontSize', fsize);
ylabel('$$e_2(t) = y_s(t) - y_m(t)$$', 'Interpreter', 'Latex', 'FontSize', fsize);
title('Erro de Sincronização do Estado y (e_2)', 'FontSize', fsize);
set(gcf, 'units', 'normalized', 'outerposition', [0 0 1 1]);
saveas(gcf, 'FIG5.png');
saveas(gcf, 'FIG5.fig');
close(fig);

% ==================== FIGURA 6: Erro e_3 ====================
fig = figure;
plot(t, e3, 'LineWidth', 2);
grid on; grid minor;
xlabel('Tempo (s)', 'FontSize', fsize);
ylabel('$$e_3(t) = z_s(t) - z_m(t)$$', 'Interpreter', 'Latex', 'FontSize', fsize);
title('Erro de Sincronização do Estado z (e_3)', 'FontSize', fsize);
set(gcf, 'units', 'normalized', 'outerposition', [0 0 1 1]);
saveas(gcf, 'FIG6.png');
saveas(gcf, 'FIG6.fig');
close(fig);

% ==================== FIGURA 7: Norma do Erro e Convergência ====================
fig = figure;
norma_erro = sqrt(e1.^2 + e2.^2 + e3.^2);

tol = 0.05; % Critério de convergência
idx_fora = find(norma_erro > tol);

if isempty(idx_fora)
    tc = 0;
    convergiu = true;
elseif idx_fora(end) == length(t)
    tc = NaN;
    convergiu = false;
else
    tc = t(idx_fora(end) + 1);
    convergiu = true;
end

rmse_sync = sqrt(mean(norma_erro.^2));

plot(t, norma_erro, 'b', 'LineWidth', 2);
hold on;
plot([t(1) t(end)], [tol tol], '--r', 'LineWidth', 1.5);

y_lim = ylim;
y_max = max(y_lim(2), 1e-3);
ylim([0 y_max]);

if convergiu
    plot([tc tc], [0 y_max], '--k', 'LineWidth', 1.5);
    h = legend('Norma do erro ||e(t)||', ...
               sprintf('Tolerância (%.2f)', tol), ...
               sprintf('Convergência (t_c = %.3f s)', tc), ...
               'Location', 'northeast');
    title(sprintf('Convergência da Sincronização (t_c = %.3f s | RMSE = %.3f)', tc, rmse_sync), 'FontSize', fsize);
else
    h = legend('Norma do erro ||e(t)||', ...
               sprintf('Tolerância (%.2f)', tol), ...
               'Location', 'northeast');
    title(sprintf('Norma do Erro de Sincronização (Não convergiu | RMSE = %.3f)', rmse_sync), 'FontSize', fsize);
end

hold off;
grid on; grid minor;
set(h, 'FontSize', fsize - 2);
xlabel('Tempo (s)', 'FontSize', fsize);
ylabel('$$\|e(t)\|$$', 'Interpreter', 'Latex', 'FontSize', fsize);
set(gcf, 'units', 'normalized', 'outerposition', [0 0 1 1]);
saveas(gcf, 'FIG7.png');
saveas(gcf, 'FIG7.fig');
close(fig);

% ==================== FIGURA 8: Atrator de Lorenz (Plano x-z) ====================
fig = figure;
plot(Xmaster(:,1), Xmaster(:,3), Xslave(:,1), Xslave(:,3), ':', 'LineWidth', 1.5);
grid on; grid minor;
h = legend('Mestre', 'Escravo', 'Location', 'northeast');
set(h, 'FontSize', fsize);
xlabel('$$x(t)$$', 'Interpreter', 'Latex', 'FontSize', fsize);
ylabel('$$z(t)$$', 'Interpreter', 'Latex', 'FontSize', fsize);
title('Diagrama de Fase do Sistema de Lorenz (Plano x-z)', 'FontSize', fsize);
set(gcf, 'units', 'normalized', 'outerposition', [0 0 1 1]);
saveas(gcf, 'FIG8.png');
saveas(gcf, 'FIG8.fig');
close(fig);