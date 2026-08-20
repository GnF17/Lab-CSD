syms s F;

x1 = [s^2+s+1, -(s+1)];
x2 = [-(s+1), s^2+s+1];

b = [F; 0];

x = [x1; x2];

m = [b x(:, 2)];
a1 = det(m)/det(x);
disp(transpose(a1)/F);

m = [x(:, 1) b];
a2 = det(m)/det(x);
disp(transpose(a2)/F);

disp("Frações Parciais:");
disp(partfrac(transpose(a1)/F));
disp(partfrac(transpose(a2)/F));