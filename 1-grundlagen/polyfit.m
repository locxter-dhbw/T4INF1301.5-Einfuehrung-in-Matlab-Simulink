% Workspace zurücksetzen
clear all;
clc;

% 11 Werte in x und y (gleiche Länge notwendig)
x = -5:5;
y = [-30 -15 4 8 4 0 -4 -12 -8 4 18];
% Koeffizienten des Polynoms durch die Punkte
degree = 3;
pfit = polyfit(x, y, 3)
% Plotten
dx = -5:0.1:5;
dy = polyval(pfit, dx);
plot(x, y, '*', dx, dy);