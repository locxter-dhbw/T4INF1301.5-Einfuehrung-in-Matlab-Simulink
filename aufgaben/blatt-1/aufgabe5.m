% Workspace zurücksetzen
clear all;
clc;

% Werte generieren
figure;
x = 0.1:0.1:5;
yexp = exp(x);
ylog = log(x);
subplot(2,1,1);
plot(x, yexp);
title('e^x');
subplot(2,1,2);
plot(x, ylog);
title('ln(x)');