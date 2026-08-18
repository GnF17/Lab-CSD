syms x y z;
eq1 = x+y+2*z == 9;
eq2 = 2*x+4*y-3*z == 1;
eq3 = 3*x+6*y-5*z == 0;
[A,B] = equationsToMatrix([eq1,eq2,eq3],[x y z]);
r = linsolve(A,B);
disp(r)