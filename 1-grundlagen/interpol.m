% Workspace zurücksetzen
clear all;
clc;

% Gibt eine n x n große Matrix
[X, Y, Z] = peaks(10);
subplot(1, 2, 1);
surf(X, Y, Z);
title('Original');

% Interpolation
xi = -3:0.1:3;
yi = xi;
% Gittermatrix aus Vektoren
[Xi, Yi] = meshgrid(xi, yi);
Zi = interp2(X, Y, Z, Xi, Yi);
subplot(1, 2, 2);
surf(Xi, Yi, Zi);
title('Interpolation');