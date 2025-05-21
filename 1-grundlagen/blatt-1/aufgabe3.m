% Workspace zurücksetzen
clear all;
clc;

% Werte generieren
figure;
x = -2:0.1:2;
y = exp(x);
plot(x, y);
title('e^x und 2^x');
hold on;
y = 2.^x;
plot(x, y);
legend('e^x', '2^x');