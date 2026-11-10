clear all;
clc;
close all;

s = tf('s');

G1 = (1000 * (s + 0.01) * (s + 6)) / (s * (s + 20) * (s + 100)); 
G2 = 10 / (s^2 + 10*s + 29); 

L = G1 * G2;

w = logspace(-3, 3, 5000); 

[mag, phase] = bode(L, w);
mag_dB = 20*log10(squeeze(mag));
phase = squeeze(phase);

idx_0dB = find(mag_dB < 0, 1, 'first');

w_0dB = interp1(mag_dB(idx_0dB-1:idx_0dB), w(idx_0dB-1:idx_0dB), 0);

phase_at_0dB = interp1(w, phase, w_0dB);
MF = 180 + phase_at_0dB; 

idx_180 = find(phase < -180, 1, 'first');

w_180 = interp1(phase(idx_180-1:idx_180), w(idx_180-1:idx_180), -180);

mag_at_180_dB = interp1(w, mag_dB, w_180);
MG = -mag_at_180_dB; 

fprintf('Frequencia de 0 dB (w_0dB): \t %.3f rad/s\n', w_0dB);
fprintf('Margem de Fase (MF): \t\t %.3f graus\n', MF);
fprintf('Frequencia de 180° (w_180): \t %.3f rad/s\n', w_180);
fprintf('Margem de Ganho (MG): \t\t %.3f dB\n\n', MG);

figure(1);
margin(L);
grid on;
title('Diagramas de Bode');
hold on;


S1 = zpk([-0.01 -6],[0 -20 -100],1000)
S2 = tf([10],[1 10 29])
S3 = series(S1,S2)

s4 = feedback(S3,1)

nyquist(s4)