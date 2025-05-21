% Workspace zurücksetzen
clear all;
clc;

% Werte generieren
x = -2*pi:0.1:2*pi;
y = tan(x);
plot(x, y);
ylim([-10 10]);
title('Tangens');