% Workspace zurücksetzen
clear all;
clc;

% Daten für 3D Linienplot
x = -1:0.05:1;
y = x;

% Daten für den Flächenplot
[X, Y] = meshgrid(x, y);

% Z-Achsen berechnen
z = x.^2 + y.^2;
Z = X.^2 + Y.^2;

% Nebeneinander plotten
subplot(1,2,1);
plot3(x,y,z);
subplot(1, 2, 2);
surf(X, Y, Z);