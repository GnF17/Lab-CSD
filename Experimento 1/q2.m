Tf = [105 126 119 129 132 128 131 135 136 132 137];
Tc = zeros(1, 11);

for i = 1:11
    Tc(i) = (Tf(i)-32)/1.8;
end

disp(max(Tc));
disp(min(Tc));
disp(mean(Tc));

tempo = [0:0.5:5];
plot(tempo, Tf);
title("Temperatura (ºF) X Tempo (min)");
xlabel("Tempo (min)");
ylabel("Temperatura (ºF)")