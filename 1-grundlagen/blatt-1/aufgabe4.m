% Workspace zurücksetzen
clear all;
clc;

% Werte generieren
figure;
x = 0.1:0.1:10;
y = log(x);
plot(x, y);
title('ln');
xlabel('Skaleneinheiten');
ylabel('Skaleneinheiten');

% Versuch ln(0)
log(0)