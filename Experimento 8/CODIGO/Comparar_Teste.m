clc;
close all;

% ================= CONFIGURAÇÃO DA COMPARAÇÃO =================
% 1. Nomes dos arquivos salvos
arquivos = {'ci_media.mat', 'acop_x.mat', 'acop_y.mat', 'acop_z.mat'};

% 2. Rótulos que vão aparecer na legenda e no eixo das barras
legendas = {'Total (50,50,50)', 'Apenas x (50,0,0)', 'Apenas y (0,50,0)', 'Apenas z (0,0,50)'};

% 3. Título do gráfico e prefixo dos arquivos de saída
titulo_grafico = 'Comparação da Convergência por Topologia de Acoplamento';
nome_saida     = 'FIG_Comparacao_Acoplamento';

% 4. Parâmetros de análise
tol = 0.05;             % Tolerância para definir convergência
limite_tempo = [0 10];  % Janela completa para evidenciar que o acoplamento só em z não converge
fsize = 18;
% ==============================================================

cores   = [0.0000 0.4470 0.7410;   % Azul
           0.8500 0.3250 0.0980;   % Laranja/Vermelho
           0.4660 0.6740 0.1880;   % Verde
           0.4940 0.1840 0.5560];  % Roxo
estilos = {'-', '--', ':', '-.'};

n_casos = length(arquivos);
legendas_finais = cell(1, n_casos + 1);
e0_vec   = zeros(1, n_casos);
tc_vec   = zeros(1, n_casos);
rmse_vec = zeros(1, n_casos);
t_max_global = 0;

% ==================== FIGURA 1: CURVAS DE ||e(t)|| ====================
fig1 = figure;
hold on;

for i = 1:n_casos
    dados = load(arquivos{i});
    t_i = dados.t;
    Xm  = dados.Xmaster;
    Xs  = dados.Xslave;
    
    if t_i(end) > t_max_global
        t_max_global = t_i(end);
    end
    
    % Erro de sincronização (padrão e = x_slave - x_master)
    e1 = Xs(:,1) - Xm(:,1);
    e2 = Xs(:,2) - Xm(:,2);
    e3 = Xs(:,3) - Xm(:,3);
    norma = sqrt(e1.^2 + e2.^2 + e3.^2);
    
    % Tempo de convergência
    idx_fora = find(norma > tol);
    if isempty(idx_fora)
        tc = 0;
    elseif idx_fora(end) == length(t_i)
        tc = NaN;
    else
        tc = t_i(idx_fora(end) + 1);
    end
    
    % Métricas para a Figura 2 (RMSE ponderado no tempo para passo variável)
    e0_vec(i)   = norma(1);
    tc_vec(i)   = tc;
    rmse_vec(i) = sqrt(trapz(t_i, norma.^2) / (t_i(end) - t_i(1)));
    
    % Cor e estilo da curva atual
    cor_i = cores(mod(i-1, size(cores,1)) + 1, :);
    est_i = estilos{mod(i-1, length(estilos)) + 1};
    
    % Plot da curva
    plot(t_i, norma, 'Color', cor_i, 'LineStyle', est_i, 'LineWidth', 2.2);
    
    if isnan(tc)
        legendas_finais{i} = sprintf('%s (não convergiu)', legendas{i});
    else
        legendas_finais{i} = sprintf('%s (t_c = %.3f s)', legendas{i}, tc);
    end
end

% Linha horizontal da tolerância
plot([0 t_max_global], [tol tol], '--k', 'LineWidth', 1.2);
legendas_finais{n_casos + 1} = sprintf('Tolerância (%.2f)', tol);

hold off;
grid on;
grid minor;
xlim(limite_tempo);
set(gca, 'FontSize', 15);
xlabel('Tempo (s)', 'FontSize', fsize);
ylabel('$$\|e(t)\|$$', 'Interpreter', 'Latex', 'FontSize', fsize);
title(titulo_grafico, 'FontSize', fsize);
h = legend(legendas_finais, 'Location', 'northeast');
set(h, 'FontSize', fsize - 3);

set(fig1, 'units', 'normalized', 'outerposition', [0 0 1 1]);
saveas(fig1, [nome_saida '.png']);
saveas(fig1, [nome_saida '.fig']);

% ==================== FIGURA 2: GRÁFICO DE MÉTRICAS ====================
fig2 = figure;

% --- Subplot 1: Erro Inicial ||e(0)|| ---
subplot(1, 3, 1);
hold on;
for i = 1:n_casos
    cor_i = cores(mod(i-1, size(cores,1)) + 1, :);
    bar(i, e0_vec(i), 0.6, 'FaceColor', cor_i);
    text(i, e0_vec(i), sprintf('%.3f', e0_vec(i)), ...
         'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', ...
         'FontSize', 13, 'FontWeight', 'bold');
end
hold off;
grid on;
y_top_e0 = max(max(e0_vec) * 1.2, 1e-3);
ylim([0 y_top_e0]);
set(gca, 'XTick', 1:n_casos, 'XTickLabel', legendas, ...
         'XTickLabelRotation', 15, 'FontSize', 13);
ylabel('$$\|e(0)\|$$', 'Interpreter', 'Latex', 'FontSize', fsize - 2);
title('Erro Inicial', 'FontSize', fsize - 2);

% --- Subplot 2: Tempo de Convergência t_c ---
subplot(1, 3, 2);
hold on;
tc_validos = tc_vec(~isnan(tc_vec));
if isempty(tc_validos) || max(tc_validos) == 0
    y_top_tc = 1;
else
    y_top_tc = max(tc_validos) * 1.25;
end

for i = 1:n_casos
    cor_i = cores(mod(i-1, size(cores,1)) + 1, :);
    if isnan(tc_vec(i))
        text(i, y_top_tc * 0.08, 'Não conv.', ...
             'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', ...
             'FontSize', 12, 'FontWeight', 'bold', 'Color', [0.8 0 0]);
    else
        bar(i, tc_vec(i), 0.6, 'FaceColor', cor_i);
        text(i, tc_vec(i), sprintf('%.3f s', tc_vec(i)), ...
             'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', ...
             'FontSize', 13, 'FontWeight', 'bold');
    end
end
hold off;
grid on;
ylim([0 y_top_tc]);
set(gca, 'XTick', 1:n_casos, 'XTickLabel', legendas, ...
         'XTickLabelRotation', 15, 'FontSize', 13);
ylabel('t_c (s)', 'FontSize', fsize - 2);
title(sprintf('Tempo de Convergência (tol = %.2f)', tol), 'FontSize', fsize - 2);

% --- Subplot 3: RMSE ---
subplot(1, 3, 3);
hold on;
for i = 1:n_casos
    cor_i = cores(mod(i-1, size(cores,1)) + 1, :);
    bar(i, rmse_vec(i), 0.6, 'FaceColor', cor_i);
    text(i, rmse_vec(i), sprintf('%.3f', rmse_vec(i)), ...
         'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', ...
         'FontSize', 13, 'FontWeight', 'bold');
end
hold off;
grid on;
y_top_rmse = max(max(rmse_vec) * 1.2, 1e-3);
ylim([0 y_top_rmse]);
set(gca, 'XTick', 1:n_casos, 'XTickLabel', legendas, ...
         'XTickLabelRotation', 15, 'FontSize', 13);
ylabel('RMSE', 'FontSize', fsize - 2);
title('RMSE da Norma do Erro', 'FontSize', fsize - 2);

set(fig2, 'units', 'normalized', 'outerposition', [0 0 1 1]);
saveas(fig2, [nome_saida '_Metricas.png']);
saveas(fig2, [nome_saida '_Metricas.fig']);