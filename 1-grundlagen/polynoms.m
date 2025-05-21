% Workspace zurücksetzen
clear all;
clc;

% p(x) = 2x^4+12x^3-44x+30
px = [2 12 0 -44 30];
% Nullstellen berechnen
zeros = roots(px)
% 1. Ableitung berechnen (Vektor der Koeffizienten)
dpx = polyder(px)
% Extremwerte bei Nullstellen der 1. Ableitung
dpxZeros = roots(dpx)
% 2. Ableitung berechnen
ddpx = polyder(dpx)
% Werte der 2. Ableitung an den Extremstellen (< 0 => Maximum, > 0 =>
% Minimum)
polyval(ddpx, dpxZeros)
% Graph plotten
x = -5.5:0.1:2;
y = polyval(px, x);
plot(x, y);