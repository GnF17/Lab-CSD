a = [6 4 5; 5 11 11; -6 -10 -11];
det(a);
b=inv(a);
[d p]=eig(a);
disp(d);
disp(p);
x=a*b;
y=b*a;
disp(x);
disp(y);
z=a*p(:,1)