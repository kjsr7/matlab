x1=-2:0.25:2;
 x2=-2:0.25:2;
 [X1 X2]=meshgrid(x1,x2);
 Z=20*(1 - exp(-0.2*sqrt(0.5*(X1.^2 + X2.^2))))- exp(0.5.*(cos(2*pi*X1) + cos(2*pi*X2))) + exp(1);
surfc(X1,X2,Z)
