%{
    1) -v(s)+(5/s)i1(s)+(i1-i3)5+(s+2)(i1-i2)=0
    (5/s + 7 + s)i1 - (s+2)i2 -5i3 = 1

2)  (s+2)(i2-i1) + (s+2)(i2-i3) + 3/s(i2) = 0
    -(s+2)i1 + (3/s + 2s + 4)i2 - (s+2)i3 = 0

3) (1+ 4/s)i3 + (s+2)(i3-i2) + 5(i3-i1) = 0
    -5i1 - (s+2)i2 + (8 + s + 4/s)i3 = 0
%}

syms s;

l1 = [(s+7+5/s) , -(s+2), -5, 1];
l2 = [-(s+2), (4+2*s+3/s), -(s+2), 0];
l3 = [-5, -(s+2), (s+8+4/s), 0];

m = [l1; l2; l3];

v = m(:, 4);
c = m(:, 1:3);

c1 = [v c(:, 2:3)];
c2 = [c(:, 1) v c(:, 3)];
c3 = [c(:, 1:2) v];

i1 = ilaplace(det(c1)/det(c));
i2 = ilaplace(det(c2)/det(c));
i3 = ilaplace(det(c3)/det(c));

disp("i1:");
simplify(i1);
collect(i1);
pretty(i1);

disp("i2:");
simplify(i2);
collect(i2);
pretty(i2);

disp("i3:");
simplify(i3);
collect(i3);
pretty(i3)