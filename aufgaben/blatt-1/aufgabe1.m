% Workspace zurücksetzen
clear all;
clc;

% Werte generieren
x = -2*pi:0.1:2*pi;
ysin = sin(x);
ycos = cos(x);
plot(x, ysin, x, ycos);
title('Sinus und Cosinus');
xlabel('Skaleneinheiten');
ylabel('Skaleneinheiten');